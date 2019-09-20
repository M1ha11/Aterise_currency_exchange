require 'date'
require_relative 'get_info'
require 'httparty'
require_relative 'options'
require 'pry'

class CurrencyExchange
  def upper(from, to)
    from.upcase!
    to.upcase!
  end

  def run
    options = Options.new.options
    return puts 'Wrong Input' if Date.parse(options[:date]) > Date.today
    upper(options[:from], options[:to])
    url = "https://api.exchangeratesapi.io/#{options[:date]}?base=#{options[:from]}&symbols=#{options[:to]}"
    response = HTTParty.get(url)
    return puts 'Wrong input' if response['error'] || response['details']
    GetInfo.new.exchange(response, options)
  end
end

CurrencyExchange.new.run