require "./lib/diagonals.rb"

module ChessBoardLabels
  ROWS = ["8", "7", "6", "5", "4", "3", "2", "1"].map do |row|
    ["a", "b", "c", "d", "e", "f", "g", "h"].map { |column| "#{column}#{row}" }
  end
  COLUMNS = ROWS.transpose
  LEFT_DIAGONALS = ROWS.get_left_diagonals
  RIGHT_DIAGONALS = ROWS.get_right_diagonals
end
