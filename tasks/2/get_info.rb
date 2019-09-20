require 'pry'

class GetInfo
  def exchange(response, options)
    to_convert_number = response['rates'][options[:to]] if response['base'] == options[:from] && response['rates']
    unless to_convert_number.nil?
      money = options[:amount].to_f * to_convert_number
      puts "#{money} #{options[:to]}"
    else
      raise ArgumentError
    end  
  end
end