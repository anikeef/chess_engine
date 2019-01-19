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

    if piece.class == Pawn && to == piece.en_passant_coordinates(@last_piece)
      @board.set_at([to[0], to[1] - piece.direction], nil)
    else
      valid_moves = piece.valid_moves
      raise IncorrectInput, "Invalid move" unless valid_moves.include?(to)
    end

    @board.move_piece(from, to)
    @last_piece = piece
    piece.moves += 1
  end

  def play
    until stalemate?
      puts
      puts @board
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
