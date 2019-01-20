class ChessPiece
  attr_reader :symbol, :color
  attr_accessor :position, :moves

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
    @moves = 0
  end

  def inspect
    "#{self.class}:#{@color}:#{@position}"
  end

  def valid_moves(moves)
    moves.map do |move|
       coordinates = relative_coordinates(move)
       coordinates if valid_move?(coordinates)
     end.compact
  end

  def valid_moves_recursive(moves)
    moves.inject([]) { |valid_moves, move| valid_moves.push(*repeated_move(move)) }.reject { |move| fatal_move?(move) }
  end

  def repeated_move(move, position = @position, valid_moves = [])
    coordinates = relative_coordinates(move, position)
    return valid_moves unless valid_move?(coordinates)
    return valid_moves << coordinates unless @board.at(coordinates).nil?
    repeated_move(move, coordinates, valid_moves << coordinates)
  end

  def valid_move?(coordinates)
    if @board.exists_at?(coordinates)
      piece = @board.at(coordinates)
      return piece.nil? || piece.color != @color
    end
    return false
  end

  def fatal_move?(to, from = @position)
    is_fatal = false
    piece = @board.at(to)
    @board.move_piece(from, to)
    is_fatal = true if @board.kings[@color].attacked?
    @board.move_piece(to, from)
    @board.set_at(to, piece)
    is_fatal
  end

  def relative_coordinates(move, position = @position)
    [position[0] + move[0], position[1] + move[1]]
  end
end
