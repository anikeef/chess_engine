require_relative "piece"
require "colorize"

module ChessEngine
  ##
  # This class provides a data structure for the chess board.
  # It is responsible for storing information about pieces positions and moving
  # them. It doesn't implement move validations and chess rules,
  # so it is possible to make any moves at this level of abstraction.

  class Board
    ##
    # Creates an empty 8x8 board as a 2-dimensional array

    def initialize
      @board = Array.new(8) { Array.new(8) { nil } }
    end

    ##
    # Sets the initial board position according to the classic chess rules

    def set_default
      [[:white, 0, 1], [:black, 7, 6]].each do |color, row1, row2|
        ["Rook", "Knight", "Elephant", "Queen", "King", "Elephant", "Knight", "Rook"].each.with_index do |class_name, column|
          self[column, row1] = Module.const_get("ChessEngine::#{class_name}").new(color)
        end

        0.upto(7) do |column|
          self[column, row2] = Pawn.new(color)
        end
      end
    end

    ##
    # Returns the piece (or nil) on the given position
    # === Example
    #   at([0, 0]) #=> <Rook ...>
    #   at([3, 3]) #=> nil


    def at(coords)
      return nil unless self.exists_at?(coords)
      @board[coords[0]][coords[1]]
    end

    ##
    # Sets the board on given coordinates to +piece+

    def set_at(coords, piece)
      @board[coords[0]][coords[1]] = piece
    end

    ##
    # Checks if the values of +coords+ are between 0 and 7
    # === Example
    #   exists_at?([0, 0]) #=> true
    #   exists_at?([8, -1]) #=> false

    def exists_at?(coords)
      coords.all? { |c| c.between?(0, 7) }
    end

    ##
    # Returns a string containing the board in printable format
    # (uses colorize gem to paint the squares)

    def to_s
      string = ""
      colors = [[:default, :light_white].cycle, [:light_white, :default].cycle].cycle

      7.downto(0) do |row|
        string += "#{row + 1} "
        colors_cycle = colors.next

        0.upto(7) do |column|
          piece = self[column, row]
          string += piece.nil? ? " " : piece.symbol
          string += " "
          string[-2..-1] = string[-2..-1].colorize(background: colors_cycle.next)
        end
        string += "\n"
      end

      string += "  a b c d e f g h"
      string
    end

    ##
    # Moves the value of +from+ coords to +to+ coords. Sets the value of +to+ to nil

    def move_piece(from, to)
      piece = self.at(from)
      self.set_at(from, nil)
      self.set_at(to, piece)
    end

    ##
    # Returns the coordinates of the king of given +color+

    def king_coords(color)
      Board.coords_list.find do |coords|
        at(coords) && at(coords).king? && at(coords).color == color
      end
    end

    ##
    # Returns the array of coordinates where pieces of given +color+ a located

    def pieces_coords(color)
      Board.coords_list.select do |coords|
        piece = at(coords)
        !piece.nil? && piece.color == color
      end
    end

    private

    def [](column, row)
      @board[column][row]
    end

    def []=(column, row, piece)
      @board[column][row] = piece
    end

    def Board.coords_list
      list = []
      (0..7).each do |x|
        (0..7).each { |y| list << [x, y]}
      end
      list
    end
  end
end
