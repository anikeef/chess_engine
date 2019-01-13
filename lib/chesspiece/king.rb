require "./lib/chesspiece.rb"
require "./lib/chess_board_labels.rb"

class King < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265A" : "\u2654"
  end

  def valid_moves
    valid_moves = []
    [0, 1, -1, 1, -1].permutation(2).to_a.uniq.each do |horizontal_step, vertical_step|
      coordinates = [@position[0] + horizontal_step, @position[1] + vertical_step]
      next unless @board.exists_at?(coordinates)
      piece = @board.at(coordinates)
      valid_moves << coordinates if piece.nil? || piece.color != @color
    end
    valid_moves
  end
end
