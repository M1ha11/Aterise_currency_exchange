require 'date'
require_relative 'get_info'
require 'httparty'
require 'pry'

class CurrencyExchange
  def initialize
    upper
    @url = "https://api.exchangeratesapi.io/#{ARGV[3]}?base=#{ARGV[1]}&symbols=#{ARGV[2]}"
  end

  def upper
    ARGV[1] = ARGV[1].upcase
    ARGV[2] = ARGV[2].upcase
  end

  def run
    return puts 'Wrong Input' if Date.parse(ARGV[3]) > Date.today
    response = HTTParty.get(@url)
    return puts 'Wrong Input' if response['error'] || response['details']
    GetInfo.new.exchange(response)
  end
end

CurrencyExchange.new.run