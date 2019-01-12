require "./lib/chesspiece.rb"

class Pawn < ChessPiece
  attr_accessor :moves

  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265F" : "\u2659"
    @moves = 0
  end

  def valid_moves
    valid_moves = []
    direction = @color == :black ? 1 : -1
    column_index = COLUMN_LETTERS.find_index(@position[0])
    row_index = 8 - @position[1].to_i
    column = COLUMNS[column_index]
    row = ROWS[row_index]
    next_row = ROWS[row_index + direction]

    next_square_label = next_row[column_index]
    next_square = @board[next_square_label]
    valid_moves << next_square_label if next_square.nil? || next_square.color != @color
    valid_moves << column[row_index + 2 * direction] if @moves == 0 && next_square.nil?

    [column_index - 1, column_index + 1].each do |index|
      next unless index.between?(0, 7)
      square_label = next_row[index]
      square = @board[square_label]
      valid_moves << square_label unless square.nil? || square.color == @color
    end
    valid_moves
  end
end
