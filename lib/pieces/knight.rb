require "./lib/piece.rb"

module Chess
  class Knight < Piece
    def initialize(color)
      super
      @symbol = (@color == :black) ? "\u265E" : "\u2658"
    end

    def moves
      [[1, 2], [2, 1], [1, -2], [-2, 1],
      [-1, 2], [2, -1], [-1, -2], [-2, -1]]
    end
  end
end
