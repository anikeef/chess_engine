module MoveValidator
  # This method is for pieces that can't move too far (knight, pawn, king)
  # def valid_moves(moves)
  #   moves.map do |move|
  #      coordinates = relative_coordinates(move)
  #      coordinates if valid_move?(coordinates)
  #   end.compact
  # end

  # For rook, elephant and queen
  def valid_moves(from)
    possible_moves(from).reject { |move| fatal_move?(from, move) }
  end

  def possible_moves(from)
    piece = @board.at(from)
    if [King, Knight].include?(piece.class)
      piece.moves.map do |move|
        to = relative_coordinates(from, move)
        to if possible_move?(to)
      end.compact
    elsif piece.class == Pawn
      pawn_possible_moves(from)
    else
      possible_moves_recursive(from)
    end
  end

  def possible_moves_recursive(from)
    piece = @board.at(from)
    piece.moves.inject([]) do |possible_moves, move|
      possible_moves.push(*repeated_move(from, move))
    end
  end

  def repeated_move(from, move, possible_moves = [])
    coordinates = relative_coordinates(from, move)
    return possible_moves unless possible_move?(coordinates)
    return possible_moves << coordinates unless @board.at(coordinates).nil?
    repeated_move(move, coordinates, possible_moves << coordinates)
  end

  def relative_coordinates(from, move)
    [from[0] + move[0], from[1] + move[1]]
  end

  def possible_move?(coordinates)
    if @board.exists_at?(coordinates)
      piece = @board.at(coordinates)
      return (piece.nil? || piece.color != @current_player.color)
    end
    return false
  end

  def fatal_move?(from, to)
    is_fatal = false
    piece = @board.at(to)
    @board.move_piece(from, to)
    is_fatal = true if check?
    @board.move_piece(to, from)
    @board.set_at(to, piece)
    is_fatal
  end

  def pawn_possible_moves(from)
    piece = @board.at(from)
    direction = piece.direction
    possible_moves = []

    next_coord = relative_coordinates(from, [0, piece.direction])
    if possible_move?(next_coord) && @board.at(next_coord).nil?
      possible_moves << next_coord
      second_coord = relative_coordinates(from, [0, direction * 2])
      possible_moves << second_coord if piece.moves_count == 0 &&
                                     possible_move?(second_coord) &&
                                     @board.at(second_coord).nil?
    end

    take_coords = [relative_coordinates(from, [-1, direction]),
                   relative_coordinates(from, [1, direction])].select do |coord|
                     possible_move?(coord) && !@board.at(coord).nil?
                   end
    possible_moves.push(*take_coords)
  end

  def en_passant_coords(from)
    return [] unless from[1].between?(3, 4) &&
                  @last_piece.class == Pawn &&
                  @last_piece.moves_count == 1
    piece_coords = [relative_coordinates(from, [1, 0]),
                    relative_coordinates(from, [-1, 0])].find do |coord|
      @board.at(coord) == @last_piece
    end
    return [] if piece_coords.nil?

    move_coords = [piece_coords[0], piece_coords[1] + direction]
    move_coords unless fatal_en_passant?(last_piece, move_coordinates)
  end
end
