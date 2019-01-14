require "./lib/chesspiece.rb"

class Pawn < ChessPiece
  attr_accessor :moves

  def initialize(color, board, position)
    super
    @symbol = (@color == :black) ? "\u265F" : "\u2659"
    @moves = 0
  end

  def valid_moves
    valid_moves = []
    direction = @color == :white ? 1 : -1

    coordinates = relative_coordinates([0, direction])
    next_piece = @board.at(coordinates)
    valid_moves << coordinates  if valid_move?(coordinates)
    coordinates = relative_coordinates([0, direction * 2])
    valid_moves << coordinates if @moves == 0 && valid_move?(coordinates) && next_piece.nil?

    valid_moves.push(*super([[-1, direction], [1, direction]]).reject { |coord| @board.at(coord).nil? })
    valid_moves
  end
end
