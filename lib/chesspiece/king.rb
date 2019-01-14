require "./lib/chesspiece.rb"

class King < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265A" : "\u2654"
  end

  def valid_moves
    super([0, 1, -1, 1, -1].permutation(2).to_a.uniq)
  end
end
