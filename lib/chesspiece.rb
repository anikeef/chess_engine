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

class Pawn < ChessPiece
  attr_accessor :moves

  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265F" : "\u2659"
    @moves = 0
  end

  def allowed_moves
    allowed_moves = []
    direction = @color == :black ? 1 : -1
    column_index = COLUMN_LETTERS.find_index(@position[0])
    row_index = 8 - @position[1].to_i
    column = COLUMNS[column_index]
    row = ROWS[row_index]
    next_row = ROWS[row_index + direction]

    next_square_label = next_row[column_index]
    next_square = @board[next_square_label]
    allowed_moves << next_square_label if next_square.nil? || next_square.color != @color
    allowed_moves << column[row_index + 2 * direction] if @moves == 0 && next_square.nil?

    [column_index - 1, column_index + 1].each do |index|
      next unless index.between?(0, 7)
      square_label = next_row[index]
      square = @board[square_label]
      allowed_moves << square_label unless square.nil? || square.color == @color
    end
    allowed_moves
  end
end

class Rook < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265C" : "\u2656"
  end

  def allowed_moves
    super([ROWS, COLUMNS])
  end
end

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

class Elephant < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u25B2" : "\u25B3"
  end

  def allowed_moves
    super([LEFT_DIAGONALS, RIGHT_DIAGONALS])
  end
end

class King < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265A" : "\u2654"
  end
end

class Queen < ChessPiece
  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265B" : "\u2655"
  end

  def allowed_moves
    super([ROWS, COLUMNS, LEFT_DIAGONALS, RIGHT_DIAGONALS])
  end
end
