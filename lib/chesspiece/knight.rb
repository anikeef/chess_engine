require "./lib/chesspiece.rb"

class Knight < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265E" : "\u2658"
  end

  def allowed_moves
    allowed_moves = []
    row_index = 8 - @position[1].to_i
    column_index = COLUMN_LETTERS.find_index(@position[0])

    allowed_rows = [row_index + 2, row_index - 2, row_index + 1, row_index - 1].map do |index|
      index >= 0 ? ROWS[index] : nil
    end

    allowed_rows[0..1].each do |row|
      unless row.nil?
        [column_index + 1, column_index - 1].each { |index| allowed_moves << row[index] if index.between?(0, 7) }
      end
    end

    allowed_rows[2..3].each do |row|
      unless row.nil?
        [column_index + 2, column_index - 2].each { |index| allowed_moves << row[index] if index.between?(0, 7) }
      end
    end
    allowed_moves.select { |label| @board[label].nil? || @board[label].color != @color }
  end
end
