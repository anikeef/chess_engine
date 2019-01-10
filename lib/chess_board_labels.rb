require "./lib/diagonals.rb"

module ChessBoardLabels
  COLUMN_LETTERS = ["a", "b", "c", "d", "e", "f", "g", "h"]
  ROW_NUMBERS = ["8", "7", "6", "5", "4", "3", "2", "1"]
  
  ROWS = ROW_NUMBERS.map do |row|
    COLUMN_LETTERS.map { |column| "#{column}#{row}" }
  end
  COLUMNS = ROWS.transpose
  LEFT_DIAGONALS = ROWS.get_left_diagonals
  RIGHT_DIAGONALS = ROWS.get_right_diagonals
end
