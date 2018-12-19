class Board

  def initialize
    @board = {}
    ["8", "7", "6", "5", "4", "3", "2", "1"].each do |string|
      ["a", "b", "c", "d", "e", "f", "g", "h"].each do |column|
        @board["#{column}#{string}"] = nil
      end
    end
  end
end
