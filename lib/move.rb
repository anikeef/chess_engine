class Move
  def initialize(board, from, to)
    @board = board
    @from = from
    @to = to
    @original_squares = []
    @original_squares << {coord: from, piece: board.at(from)}
    @original_squares << {coord: to, piece: board.at(to)}
    if en_passant?
      @is_en_passant = true
      @en_passant_coord = [to[0], from[1]]
      @original_squares << {coord: @en_passant_coord, piece: board.at(@en_passant_coord)}
    end
  end

  def commit
    @board.move_piece(@from, @to)
    if @is_en_passant
      @board.set_at(@en_passant_coord, nil)
    end
  end

  def rollback
    @original_squares.each do |square|
      @board.set_at(square[:coord], square[:piece])
    end
  end

  def en_passant?
    @board.at(@from).class == Pawn && @from[0] != @to[0] && @board.at(@to).nil?
  end
end
