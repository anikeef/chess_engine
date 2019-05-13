module Chess
  class Move
    def initialize(board, from, to)
      @board = board
      @from = from
      @to = to
      @original_squares = []
      @original_squares << {coord: from, piece: board.at(from)}
      @original_squares << {coord: to, piece: board.at(to)}
      if en_passant?
        @en_passant_coord = [to[0], from[1]]
        @original_squares << {coord: @en_passant_coord, piece: board.at(@en_passant_coord)}
      end
    end

    def commit
      if en_passant?
        @board.set_at(@en_passant_coord, nil)
      end
      @board.move_piece(@from, @to)
    end

    def rollback
      @original_squares.each do |square|
        @board.set_at(square[:coord], square[:piece])
      end
    end

    private

    def en_passant?
      @board.at(@from).pawn? && @from[0] != @to[0] && @board.at(@to).nil?
    end
  end
end
