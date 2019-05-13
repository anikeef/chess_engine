require "./lib/chesspiece.rb"

class Rook < ChessPiece
  def initialize(color)
    super
    @symbol = (@color == :black) ? "\u265C" : "\u2656"
  end

  def moves
    [[1, 0], [0, 1], [-1, 0], [0, -1]]
  end
end
