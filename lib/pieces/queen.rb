require "./lib/chesspiece.rb"

class Queen < ChessPiece
  MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0],
          [1, 1], [1, -1], [-1, 1], [-1, -1]]

  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265B" : "\u2655"
  end

  def valid_moves
    valid_moves_recursive(MOVES)
  end
end
