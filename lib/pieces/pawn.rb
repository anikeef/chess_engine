require "./lib/chesspiece.rb"

class Pawn < ChessPiece
  attr_reader :direction

  def initialize(color)
    super
    @symbol = (@color == :black) ? "\u265F" : "\u2659"
    @direction = (@color == :white) ? 1 : -1
  end

  def en_passant_coordinates(last_piece)
    return unless @position[1].between?(3, 4) && last_piece.class == Pawn && last_piece.moves == 1
    piece_coordinates = [relative_coordinates([1, 0]), relative_coordinates([-1, 0])].find do |coord|
      @board.exists_at?(coord) && @board.at(coord) == last_piece
    end
    return if piece_coordinates.nil?

    move_coordinates = [piece_coordinates[0], piece_coordinates[1] + direction]
    move_coordinates unless fatal_en_passant?(last_piece, move_coordinates)
  end

  def fatal_en_passant?(last_piece, move_coordinates)
    @board.set_at(last_piece.position, nil)
    is_fatal = fatal_move?(move_coordinates)
    @board.set_at(last_piece.position, last_piece)
    is_fatal
  end
end
