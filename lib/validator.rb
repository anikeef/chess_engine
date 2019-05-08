module MoveValidator
  # This method is for pieces that can't move too far (knight, pawn, king)
  def valid_moves(moves)
    moves.map do |move|
       coordinates = relative_coordinates(move)
       coordinates if valid_move?(coordinates)
    end.compact
  end

  # For rook, elephant and queen
  def valid_moves_recursive(moves)
    moves.inject([]) { |valid_moves, move| valid_moves.push(*repeated_move(move)) }.reject { |move| fatal_move?(move) }
  end

  def repeated_move(move, position = @position, valid_moves = [])
    coordinates = relative_coordinates(move, position)
    return valid_moves unless valid_move?(coordinates)
    return valid_moves << coordinates unless @board.at(coordinates).nil?
    repeated_move(move, coordinates, valid_moves << coordinates)
  end
end
