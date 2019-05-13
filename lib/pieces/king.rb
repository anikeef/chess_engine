require "./lib/piece.rb"

module Chess
  class King < Piece
    def initialize(color)
      super
      @symbol = (@color == :black) ? "\u265A" : "\u2654"
    end

    def moves
      [[0, 1], [0, -1], [1, 0], [-1, 0],
      [1, 1], [1, -1], [-1, 1], [-1, -1]]
    end
  end
end
