require "./lib/chesspiece.rb"

class King < ChessPiece
  MOVES = [[0, 1], [0, -1], [1, 0], [-1, 0],
          [1, 1], [1, -1], [-1, 1], [-1, -1]]

  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265A" : "\u2654"
  end

  def valid_moves(steps = MOVES)
    super(steps)
  end
  end
end
