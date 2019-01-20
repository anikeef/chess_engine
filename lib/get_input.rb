module Input
  def get_input(input_message, regex = nil, err_message = "Incorrect input, try again")
    begin
      print input_message
      input = gets.chomp
      if block_given?
        raise unless yield(input)
      else
        raise unless regex.match?(input)
      end
    rescue
      puts err_message
      retry
    end
    input
  end
end
