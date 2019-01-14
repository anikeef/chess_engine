require "./lib/chess_board_labels.rb"

class ChessPiece
  attr_reader :symbol, :color
  include ChessBoardLabels

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def valid_moves(steps)
    steps.map do |horizontal_step, vertical_step|
       coordinates = [@position[0] + horizontal_step, @position[1] + vertical_step]
       coordinates if valid_move?(coordinates)
     end.compact
  end

  def valid_moves_recursive(steps)
    steps.inject([]) { |valid_moves, step| valid_moves.push(*repeated_step(step)) }
  end

  def repeated_step(step, position = @position, valid_moves = [])
    coordinates = [position[0] + step[0], position[1] + step[1]]
    return valid_moves unless valid_move?(coordinates)
    return valid_moves << coordinates unless @board.at(coordinates).nil?
    repeated_step(step, coordinates, valid_moves << coordinates)
  end

  def valid_move?(coordinates)
    if @board.exists_at?(coordinates)
      piece = @board.at(coordinates)
      return piece.nil? || piece.color != @color
    end
    return false
  end

  def relative_coordinates(step) do
    [@position[0] + step[0], @position[1] + step[1]]
  end
end
