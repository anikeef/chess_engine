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
end
