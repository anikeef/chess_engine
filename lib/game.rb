require "./lib/board.rb"
require "./lib/player.rb"

class Game

  def initialize
    @board = Board.new
    @board.set_default
    @players = [Player.new(:white), Player.new(:black)]
    @players_cycle = @players.cycle
    @current_player = @players_cycle.next
    @last_piece = nil
  end

  def make_step(from, to)
    piece = @board.at(from)
    raise IncorrectInput, "Empty square is chosen" if piece.nil?
    raise IncorrectInput, "This is not your piece" unless piece.color == @current_player.color
    unless en_passant(piece, to)
      valid_moves = piece.valid_moves
      raise IncorrectInput, "Invalid move" unless valid_moves.include?(to)
    end

    @board.move_piece(from, to)
    @last_piece = piece
    piece.moves += 1
    promote_pawn(piece) if piece.class == Pawn && to[1] == 7
  end

  def en_passant(moving_piece, target_coord)
    if moving_piece.class == Pawn && target_coord == moving_piece.en_passant_coordinates(@last_piece)
      @board.set_at([target_coord[0], target_coord[1] - moving_piece.direction], nil)
      return true
    end
    false
  end

  def promote_pawn(pawn)
    piece_classes = [Queen, Rook, Knight, Elephant]
    @board.set_at(pawn.position, piece_classes[@current_player.input_promotion - 1].new(@current_player.color, @board, pawn.position))
  end

  def play
    until stalemate?
      puts "\n#{@board}"
      declare_check if check?
      begin
        make_step(*@current_player.input_step)
      rescue IncorrectInput => e
        puts "#{e.message}. Try again"
        retry
      end
      @current_player = @players_cycle.next
    end
    game_over
  end

  def check?
    @board.kings[@current_player.color].attacked?
  end

  def stalemate?
    @board.pieces(@current_player.color).all? { |piece| piece.valid_moves.empty? }
  end

  def game_over
    puts @board
    if check?
      declare_mate
    else
      puts "Stalemate!"
    end
  end

  def declare_mate
    puts "#{@current_player.color.to_s.capitalize} player got mated!"
  end

  def declare_check
    puts "#{@current_player.color.to_s.capitalize} player is given a check"
  end
end
