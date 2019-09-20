require 'date'
require 'httparty'
require 'pry'
require 'rack-flash'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
  end

  use Rack::Flash

  get '/' do
    @currencies = Currency.all
    @result = params[:result]
    @title = params[:title]
    erb :index
  end

  post '/' do
    if params[:amount]
      check_date(params[:date])
      @result = params[:amount] if params[:from] == params[:to]
      convert_number = get_rate(params[:from], params[:to], params[:date])
      @result = calculate(params[:amount], params[:to], convert_number)
      redirect "/?result=#{@result}&title=#{params[:to]}"
    end
  end

  helpers do
    def get_rate(from, to, date)
      if date.empty?
        url = "https://api.exchangeratesapi.io/latest?base=#{from}&symbols=#{to}"
      else
        url = "https://api.exchangeratesapi.io/#{date}?base=#{from}&symbols=#{to}"
      end
      response = HTTParty.get(url)
      return 'Wrong Input' if response['error'] || response['details']
      exchange(response, to)
    end

    def exchange(response, to)
      to_convert_number = response['rates'][to]
    end

    def check_date(date)
      unless date.empty?
        if Date.parse(date) > Date.today
          @result = 'Wrong date'
          redirect "/?result=#{@result}"
        end
      end
    end

    def get_result
    end

    def calculate(amount, to, convert_number)
      if convert_number.nil? || convert_number == 'Wrong Input'
        'Wrong Date'
      else
        money = amount.to_f * convert_number
        money.round(2)
      end
    end
  end
end