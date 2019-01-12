require "./lib/chesspiece.rb"

class Queen < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265B" : "\u2655"
  end

  def allowed_moves
    super([ROWS, COLUMNS, LEFT_DIAGONALS, RIGHT_DIAGONALS])
  end
end
