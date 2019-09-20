require_relative 'get_info'
require 'httparty'
require 'pry'

class CurrencyExchange
  def initialize
    upper
    @url = "https://api.exchangeratesapi.io/latest?base=#{ARGV[1]}&symbols=#{ARGV[2]}"
  end

  def upper
    ARGV[1] = ARGV[1].upcase
    ARGV[2] = ARGV[2].upcase
  end

  def run
    response = HTTParty.get(@url)
    return puts response['error'] if response['error']
    GetInfo.new.exchange(response)
  end
end

CurrencyExchange.new.run