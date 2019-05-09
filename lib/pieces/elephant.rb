require "./lib/chesspiece.rb"

class Elephant < ChessPiece
  def initialize(color)
    super
    @symbol = (@color == :black) ? "\u25B2" : "\u25B3"
  end

  def moves
    [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end
end
