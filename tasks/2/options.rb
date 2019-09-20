require 'optparse'

class Options
  def initialize
    @options = {
      amount: 100,
      from: 'USD',
      to: 'EUR',
      date: '2019-01-01'
    }
  end

  def options
    @option_parser = OptionParser.new do |option|
      option.on('-a', '--amount AMOUNT')
      option.on('-f', '--from FROM')
      option.on('-t', '--to TO')
      option.on('-d', '--date DATE')
    end.parse!(into: @options)
    @options
  end
end