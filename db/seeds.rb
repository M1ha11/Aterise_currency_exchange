require 'httparty'
require 'pry'

currencies = {}
url = 'https://api.exchangeratesapi.io/latest'
response = HTTParty.get(url)
url_for_eur = 'https://api.exchangeratesapi.io/latest?base=USD&symbols=EUR'
response_for_eur = HTTParty.get(url_for_eur)
binding.pry
response_for_eur['rates']
return puts response['error'] if response['error'] || response['details']
response['rates'].merge!(response_for_eur['rates'])
binding.pry
response['rates'].each do |currency, rate|
  Currency.create({title: currency})
end
