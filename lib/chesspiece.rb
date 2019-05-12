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
    ["Pawn", "King", "Elephant", "Queen"].include? self.class.to_s
  end

  def beats_straigt?
    ["Rook", "Queen", "King"].include? self.class.to_s
  end

  def knight?
    self.class.to_s == "Knight"
  end

  def king?
    self.class.to_s == "King"
  end

  def pawn?
    self.class.to_s == "Pawn"
  end
end
