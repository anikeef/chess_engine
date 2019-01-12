require "./lib/chesspiece.rb"
require "./lib/chess_board_labels.rb"

class King < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265A" : "\u2654"
  end

  def valid_moves
    valid_moves = []
    horizontal_index = 8 - @position[1].to_i
    vertical_index = COLUMN_LETTERS.find_index(@position[0])

    [0, 1, -1, 1, -1].permutation(2).to_a.uniq.each do |horizontal_step, vertical_step|
      coordinates = [horizontal_index + horizontal_step, vertical_index + vertical_step]
      if coordinates.all? { |c| c.between?(0, 7) }
        label = ROWS[coordinates[0]][coordinates[1]]
        square = @board[label]
        valid_moves << label if square.nil? || square.color != @color
      end
    end
    valid_moves
  end
end
