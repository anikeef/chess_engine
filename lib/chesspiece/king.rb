require "./lib/chesspiece.rb"

class King < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265A" : "\u2654"
  end
end
