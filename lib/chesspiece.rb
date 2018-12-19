class ChessPiece
  def initialize(color)
    @color = color
  end
end

class Pawn < ChessPiece
  def initialize(color)
    super
    @symbol = (@color == :black) ? "\u265F" : "\u2659"
  end
end

class Rook < ChessPiece
  def initialize(color)
    super
    @symbol = (@color == :black) ? "\u265C" : "\u2656"
  end
end

class Knight < ChessPiece
  def initialize(color)
    super
    @symbol = (@color == :black) ? "\u265E" : "\u2658"
  end
end

class Elephant < ChessPiece
  def initialize(color)
    super
    @symbol = (@color == :black) ? "\u265D" : "\u2657"
  end
end

class King < ChessPiece
  def initialize(color)
    super
    @symbol = (@color == :black) ? "\u265A" : "\u2654"
  end
end

class Queen < ChessPiece
  def initialize(color)
    super
    @symbol = (@color == :black) ? "\u265B" : "\u2655"
  end
end
