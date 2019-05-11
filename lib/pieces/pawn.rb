require "./lib/chesspiece.rb"

class Pawn < ChessPiece
  attr_reader :direction

  def initialize(color)
    super
    @symbol = (@color == :black) ? "\u265F" : "\u2659"
    @direction = (@color == :white) ? 1 : -1
  end
end
