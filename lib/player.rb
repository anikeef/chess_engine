class IncorrectInput < StandardError; end

class Player
  attr_reader :color

  COLUMN_LETTERS = ["a", "b", "c", "d", "e", "f", "g", "h"]

  def initialize(color)
    @color = color
  end

  def input_step
    column_letters = ["a"]
    print "#{@color.to_s.capitalize}'s move (e. g. \"e2 e4\"): "
    input = gets.gsub(/\s+/, "")
    unless /^[abcdefgh][12345678][abcdefgh][12345678]$/.match?(input)
      raise IncorrectInput, "Input must look like \"e2 e4\" or \"a6b5\""
    end
    from = [COLUMN_LETTERS.find_index(input[0]), input[1].to_i - 1]
    to = [COLUMN_LETTERS.find_index(input[2]), input[3].to_i - 1]
    [from, to]
  end
end
