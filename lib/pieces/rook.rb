require "./lib/chesspiece.rb"

module Chess
  class Rook < Piece
    def initialize(color)
      super
      @symbol = (@color == :black) ? "\u265C" : "\u2656"
    end

    def moves
      [[1, 0], [0, 1], [-1, 0], [0, -1]]
    end
  end
end
