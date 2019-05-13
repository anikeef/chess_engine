class ChessPiece
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
    ["Elephant", "Queen"].include? self.class.to_s
  end

  def beats_straight?
    ["Rook", "Queen", "King"].include? self.class.to_s
  end

  ["knight", "king", "pawn", "rook", "queen", "elephant"].each do |piece|
    define_method(:"#{piece}?") do
      self.class.to_s == piece.capitalize
    end
  end
end
