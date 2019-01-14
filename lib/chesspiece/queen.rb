require "./lib/chesspiece.rb"

class Queen < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265B" : "\u2655"
  end

  def valid_moves
    valid_moves_recursive([0, 1, -1, 1, -1].permutation(2).to_a.uniq)
  end
end
