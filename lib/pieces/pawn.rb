require "./lib/chesspiece.rb"

module Chess
  class Pawn < Piece
    attr_reader :direction

    def initialize(color)
      super
      @symbol = (@color == :black) ? "\u265F" : "\u2659"
      @direction = (@color == :white) ? 1 : -1
    end
  end
end
