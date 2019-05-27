module ChessEngine
  ##
  # This module contains all the methods needed to check if
  # some move is valid or not. It is included in the Game class and so uses
  # some of its attributes: board, current_color and last_piece (for en passant only)

  module MoveValidator

    ## Excludes from valid_moves all fatal moves

    def safe_moves(from)
      valid_moves(from).reject { |move| fatal_move?(from, move) }
    end

    ##
    # Returns an array of valid moves for a piece at the given position.
    # Note: this method doesn't exclude moves that lead current king to be attacked
    # (See +#safe_moves+ method)

    def valid_moves(from)
      piece = @board.at(from)
      if piece.king? || piece.knight?
        piece.moves.map do |move|
          to = relative_coords(from, move)
          to if possible_move?(to)
        end.compact
      elsif piece.pawn?
        pawn_valid_moves(from)
      else
        valid_moves_recursive(from)
      end
    end

    ##
    # Returns an array of coordinates that can be reached by recursively
    # applying the given +move+, starting from the +from+ coordinates

    private

    def repeated_move(from, move, valid_moves = [])
      coords = relative_coords(from, move)
      return valid_moves unless possible_move?(coords)
      return valid_moves << coords unless @board.at(coords).nil?
      repeated_move(coords, move, valid_moves << coords)
    end

    ##
    # Returns coordinates that will be reached after applying the +move+,
    # starting from the +from+ coordinates

    def relative_coords(from, move)
      [from[0] + move[0], from[1] + move[1]]
    end

    ##
    # Returns true if:
    # * The 8x8 board exists at given coordinates
    # * Board at given coordinates is empty or it contains a piece with the same
    #   color as the current_color

    def possible_move?(coords)
      if @board.exists_at?(coords)
        piece = @board.at(coords)
        return (piece.nil? || piece.color != @current_color)
      end
      return false
    end

    ##
    # Returns true if the current king is attacked after the given move

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

    ##
    # Returns additional valid coordinates for the pawn if available

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

    ##
    # This method is used by #valid_moves for pieces like Queen, Rook and Elephant,
    # that should move recursively

    def valid_moves_recursive(from)
      piece = @board.at(from)
      piece.moves.inject([]) do |valid_moves, move|
        valid_moves.push(*repeated_move(from, move))
      end
    end
  end
end
