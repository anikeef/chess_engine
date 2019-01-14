require "./lib/chesspiece.rb"

class Knight < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265E" : "\u2658"
  end

  def valid_moves
    super([[1, 2], [2, 1], [1, -2], [-2, 1],
          [-1, 2], [2, -1], [-1, -2], [-2, -1]])
  end
end
