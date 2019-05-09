require "./lib/chesspiece.rb"

class Queen < ChessPiece
  def initialize(color)
    super
    @symbol = (@color == :black) ? "\u265B" : "\u2655"
  end

  def moves
    [[0, 1], [0, -1], [1, 0], [-1, 0],
    [1, 1], [1, -1], [-1, 1], [-1, -1]]
  end
end
