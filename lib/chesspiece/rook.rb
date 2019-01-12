require "./lib/chesspiece.rb"

class Rook < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265C" : "\u2656"
  end

  def allowed_moves
    super([ROWS, COLUMNS])
  end
end
