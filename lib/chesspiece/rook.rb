require "./lib/chesspiece.rb"

class Rook < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265C" : "\u2656"
  end

  def valid_moves
    valid_moves_recursive([[0, 1], [0, -1], [1, 0], [-1, 0]])
  end
end
