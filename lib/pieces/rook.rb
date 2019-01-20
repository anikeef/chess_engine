require "./lib/chesspiece.rb"

class Rook < ChessPiece
  MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0]]

  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265C" : "\u2656"
  end

  def valid_moves
    valid_moves_recursive(MOVES)
  end
end
