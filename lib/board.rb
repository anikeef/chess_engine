require "./lib/chesspiece.rb"
require "colorize"

class Board

  def initialize
    @board = {}
    ["8", "7", "6", "5", "4", "3", "2", "1"].each do |string|
      ["a", "b", "c", "d", "e", "f", "g", "h"].each do |column|
        @board["#{column}#{string}"] = nil
      end
    end
  end

  def set_default
    [[:white, 1, 2], [:black, 8, 7]].each do |color, row1, row2|
      @board["a#{row1}"] = Rook.new(color)
      @board["h#{row1}"] = Rook.new(color)
      @board["b#{row1}"] = Knight.new(color)
      @board["g#{row1}"] = Knight.new(color)
      @board["c#{row1}"] = Elephant.new(color)
      @board["f#{row1}"] = Elephant.new(color)
      @board["d#{row1}"] = Queen.new(color)
      @board["e#{row1}"] = King.new(color)

      ["a", "b", "c", "d", "e", "f", "g", "h"].each do |column|
        @board["#{column}#{row2}"] = Pawn.new(color)
      end
    end
  end

  def to_s
    string = ""
    colors = [[:default, :light_white].cycle, [:light_white, :default].cycle].cycle

    8.downto(1) do |row|
      string += "#{row} "
      colors_cycle = colors.next

      ["a", "b", "c", "d", "e", "f", "g", "h"].each do |column|
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
end
