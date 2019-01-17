require "./lib/chesspiece.rb"
require "colorize"
require "./lib/chess_board_labels.rb"
Dir["./lib/chesspiece/*.rb"].each { |file| require file }

class IncorrectInput < StandardError; end

class Board
  attr_reader :kings
  include ChessBoardLabels

  def initialize
    @board = Array.new(8) { Array.new(8) { nil } }
  end

  def set_default
    [[:white, 0, 1], [:black, 7, 6]].each do |color, row1, row2|
      [Rook, Knight, Elephant, Queen, King, Elephant, Knight, Rook].each.with_index do |piece, column|
        self[column, row1] = piece.new(color, self, [column, row1])
      end

      0.upto(7) do |column|
        self[column, row2] = Pawn.new(color, self, [column, row2])
      end
    end
    @kings = {white: self[4, 0], black: self[4, 7]}
  end

  def [](column, row)
    @board[column][row]
  end

  def []=(column, row, piece)
    @board[column][row] = piece
  end

  def at(coordinates)
    return nil unless self.exists_at?(coordinates)
    @board[coordinates[0]][coordinates[1]]
  end

  def set_at(coordinates, piece)
    @board[coordinates[0]][coordinates[1]] = piece
  end

  def exists_at?(coordinates)
    coordinates.all? { |c| c.between?(0, 7) }
  end

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

  def move_piece(from, to)
    piece = self.at(from)
    self.set_at(from, nil)
    self.set_at(to, piece)
    piece.position = to unless piece.nil? 
  end

  def pieces(color)
    @board.flatten.compact.select { |piece| piece.color == color }
  end
end
