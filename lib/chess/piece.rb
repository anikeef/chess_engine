module Chess
  class Piece
    attr_reader :symbol, :color
    attr_accessor :moves_count

    def initialize(color)
      @color = color
      @moves_count = 0
    end

    def inspect
      "#{self.class}:#{@color}"
    end

    def beats_diagonally?
      elephant? || queen?
    end

    def beats_straight?
      rook? || queen?
    end

    ["knight", "king", "pawn", "rook", "queen", "elephant"].each do |piece|
      define_method(:"#{piece}?") do
        self.class.to_s == "Chess::#{piece.capitalize}"
      end
    end
  end

  class Elephant < Piece
    def initialize(color)
      super
      @symbol = (@color == :black) ? "\u25B2" : "\u25B3"
    end

    def moves
      [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    end
  end

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

  class Pawn < Piece
    attr_reader :direction

    def initialize(color)
      super
      @symbol = (@color == :black) ? "\u265F" : "\u2659"
      @direction = (@color == :white) ? 1 : -1
    end
  end

  class Queen < Piece
    def initialize(color)
      super
      @symbol = (@color == :black) ? "\u265B" : "\u2655"
    end

    def moves
      [[0, 1], [0, -1], [1, 0], [-1, 0],
      [1, 1], [1, -1], [-1, 1], [-1, -1]]
    end
  end

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
