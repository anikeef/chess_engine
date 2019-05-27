module ChessEngine
  ##
  # This class is made to make move canceling easier if something goes wrong.

  class Move
    def initialize(board, from, to)
      @board = board
      @from = from
      @to = to
      @original_squares = []
      @original_squares << {coords: from, piece: board.at(from)}
      @original_squares << {coords: to, piece: board.at(to)}
      if en_passant?
        @en_passant_coords = [to[0], from[1]]
        @original_squares << {coords: @en_passant_coords, piece: board.at(@en_passant_coords)}
      end
    end

    ##
    # Applies the move to the board

    def commit
      if en_passant?
        @board.set_at(@en_passant_coords, nil)
      end
      @board.move_piece(@from, @to)
    end

    ##
    # Moves pieces back and returns the board to the previous state

    def rollback
      @original_squares.each do |square|
        @board.set_at(square[:coords], square[:piece])
      end
    end

    private

    def en_passant?
      @board.at(@from).pawn? && @from[0] != @to[0] && @board.at(@to).nil?
    end
  end
end
