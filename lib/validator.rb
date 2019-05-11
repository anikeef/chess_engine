module MoveValidator
  def valid_moves(from)
    possible_moves(from).reject { |move| fatal_move?(from, move) }
  end

  def possible_moves(from)
    piece = @board.at(from)
    if [King, Knight].include?(piece.class)
      piece.moves.map do |move|
        to = relative_coords(from, move)
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
    coordinates = relative_coords(from, move)
    return possible_moves unless possible_move?(coordinates)
    return possible_moves << coordinates unless @board.at(coordinates).nil?
    repeated_move(move, coordinates, possible_moves << coordinates)
  end

  def relative_coords(from, move)
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
    move = Move.new(@board, from, to)
    move.commit
    is_fatal = true if check?
    move.rollback
    is_fatal
  end

  def pawn_possible_moves(from)
    pawn = @board.at(from)
    direction = pawn.direction
    moves = []
    next_coords = relative_coords(from, [0, direction])
    jump_coords = relative_coords(from, [0, direction * 2])
    take_coords = [relative_coords(from, [1, direction]),
      relative_coords(from, [-1, direction])]
    if @board.exists_at?(next_coords) && @board.at(next_coords).nil?
      moves << next_coords
      moves << jump_coords unless pawn.moves_count > 0 || @board.at(jump_coords)
    end
    take_coords.each do |coords|
      moves << coords if @board.at(coords) && @board.at(coords).color != pawn.color
    end
    en_passant_coords(from) ? moves << en_passant_coords(from) : moves
  end

  def en_passant_coords(from)
    pawn = @board.at(from)
    [1, -1].each do |x|
      next_coords = [from[0] + x, from[1]]
      next_piece = @board.at(next_coords)
      if next_piece.class == Pawn && next_piece == @last_piece &&
        next_piece.moves_count == 1 && from[1].between?(3, 4)
          return [from[0] + x, from[1] + pawn.direction]
      end
    end
    nil
  end
end
