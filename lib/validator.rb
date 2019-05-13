module Chess
  module MoveValidator
    def safe_moves(from)
      valid_moves(from).reject { |move| fatal_move?(from, move) }
    end

    def valid_moves(from)
      piece = @board.at(from)
      if piece.king? || piece.knight?
        piece.moves.map do |move|
          to = relative_coords(from, move)
          to if valid_move?(to)
        end.compact
      elsif piece.class == Pawn
        pawn_valid_moves(from)
      else
        valid_moves_recursive(from)
      end
    end

    def valid_moves_recursive(from)
      piece = @board.at(from)
      piece.moves.inject([]) do |valid_moves, move|
        valid_moves.push(*repeated_move(from, move))
      end
    end

    def repeated_move(from, move, valid_moves = [])
      coordinates = relative_coords(from, move)
      return valid_moves unless valid_move?(coordinates)
      return valid_moves << coordinates unless @board.at(coordinates).nil?
      repeated_move(coordinates, move, valid_moves << coordinates)
    end

    def relative_coords(from, move)
      [from[0] + move[0], from[1] + move[1]]
    end

    def valid_move?(coordinates)
      if @board.exists_at?(coordinates)
        piece = @board.at(coordinates)
        return (piece.nil? || piece.color != @current_color)
      end
      return false
    end

    def fatal_move?(from, to)
      is_fatal = false
      move = Move.new(@board, from, to)
      move.commit
      is_fatal = true if king_attacked?
      move.rollback
      is_fatal
    end

    def pawn_valid_moves(from)
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
end
