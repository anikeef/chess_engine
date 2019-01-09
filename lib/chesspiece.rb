require "./lib/chess_board_labels.rb"

class ChessPiece
  attr_reader :symbol, :color
  include ChessBoardLabels

  def initialize(color)
    @color = color
  end

  def get_allowed_moves(position, current_board, areas)
    allowed_moves = []

    areas.each do |area|
      line = area.find { |array| array.include?(position) }
      index = line.find_index(position)

      [line[0..(index - 1)].reverse, line[(index + 1)..-1]].each do |arr|
        arr.each do |square_label|
          square = current_board[square_label]

          if square.nil?
            allowed_moves << square_label
          elsif square.color != self.color
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

  def get_allowed_moves(position, current_board)
    super(position, current_board, [ROWS, COLUMNS])
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
    @symbol = (@color == :black) ? "\u25B2" : "\u25B3"
  end

  def get_allowed_moves(position, current_board)
    super(position, current_board, [LEFT_DIAGONALS, RIGHT_DIAGONALS])
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

  def get_allowed_moves(position, current_board)
    super(position, current_board, [ROWS, COLUMNS, LEFT_DIAGONALS, RIGHT_DIAGONALS])
  end
end
