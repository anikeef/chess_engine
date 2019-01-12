require "./lib/chess_board_labels.rb"

class ChessPiece
  attr_reader :symbol, :color
  include ChessBoardLabels

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def allowed_moves(areas)
    allowed_moves = []

    areas.each do |area|
      line = area.find { |array| array.include?(@position) }
      index = line.find_index(@position)

      [line.take_while.with_index { |a, i| i < index }.reverse,
       line.drop_while.with_index { |a, i| i <= index }].each do |arr|
        arr.each do |square_label|
          square = @board[square_label]

          if square.nil?
            allowed_moves << square_label
          elsif square.color != @color
            allowed_moves << square_label
            break
          else
            break
          end

        end
      end
    end
    allowed_moves
  end
end
