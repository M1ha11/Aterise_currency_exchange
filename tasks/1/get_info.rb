require 'pry'

class GetInfo
  def exchange(response)
    to_convert_number = response['rates'][ARGV[2]] if response['base'] == ARGV[1] && response['rates']
    unless to_convert_number.nil?
      money = ARGV[0].to_f * to_convert_number
      puts "#{money} #{ARGV[2]}"
    else
      raise ArgumentError
    end  
  end  
end