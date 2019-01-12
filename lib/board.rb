require "./lib/chesspiece.rb"
require "colorize"

class IncorrectInput < StandardError; end

class Board
  include ChessBoardLabels

  def initialize
    @board = {}
    ROWS.each do |row|
      row.each { |label| @board[label] = nil }
    end
  end

  def set_default
    [[:white, 1, 2], [:black, 8, 7]].each do |color, row1, row2|
      @board["a#{row1}"] = Rook.new(color, self, "a#{row1}")
      @board["h#{row1}"] = Rook.new(color, self, "h#{row1}")
      @board["b#{row1}"] = Knight.new(color, self, "b#{row1}")
      @board["g#{row1}"] = Knight.new(color, self, "g#{row1}")
      @board["c#{row1}"] = Elephant.new(color, self, "c#{row1}")
      @board["f#{row1}"] = Elephant.new(color, self, "f#{row1}")
      @board["d#{row1}"] = Queen.new(color, self, "d#{row1}")
      @board["e#{row1}"] = King.new(color, self, "e#{row1}")

      COLUMN_LETTERS.each do |column|
        @board["#{column}#{row2}"] = Pawn.new(color, self, "#{column}#{row2}")
      end
    end
  end

  def [](square)
    @board[square]
  end

  def []=(square, piece)
    @board[square] = piece
  end

  def to_s
    string = ""
    colors = [[:default, :light_white].cycle, [:light_white, :default].cycle].cycle

    8.downto(1) do |row|
      string += "#{row} "
      colors_cycle = colors.next

      COLUMN_LETTERS.each do |column|
        content = @board["#{column}#{row}"]
        string += content.nil? ? " " : content.symbol
        string += " "
        string[-2..-1] = string[-2..-1].colorize(background: colors_cycle.next)
      end
      string += "\n"
    end
    
    string += "  a b c d e f g h"
    string
  end

  def move_piece(point_from, point_to)
    raise IncorrectInput if @board[point_from].nil?
    piece = @board[point_from]
    @board[point_from] = nil
    @board[point_to] = piece
  end
end
