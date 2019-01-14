require "./lib/chesspiece.rb"

class Elephant < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u25B2" : "\u25B3"
  end

  def valid_moves
    valid_moves_recursive([[1, 1], [1, -1], [-1, 1], [-1, -1]])
  end
end
