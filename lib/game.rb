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
    return castling(from.size) if to == :castling
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
    promotion(piece) if piece.class == Pawn && [7, 0].include?(to[1])
  end

  def play
    catch(:exit) do
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
  end

  def en_passant(moving_piece, target_coord)
    if moving_piece.class == Pawn && target_coord == moving_piece.en_passant_coordinates(@last_piece)
      @board.set_at([target_coord[0], target_coord[1] - moving_piece.direction], nil)
      return true
    end
    false
  end

  def promotion(pawn)
    piece_classes = [Queen, Rook, Knight, Elephant]
    @board.set_at(pawn.position, piece_classes[@current_player.input_promotion - 1].new(@current_player.color, @board, pawn.position))
  end

  def castling(length)
    row = @current_player.color == :white ? 0 : 7
    king = @board[4, row]
    rook = length == 2 ? @board[7, row] : @board[0, row]
    line = length == 2 ? [5, 6] : [1, 2, 3]
    raise IncorrectInput, "Invalid castling" unless
      king.class == King && rook.class == Rook &&
      king.moves == 0 && rook.moves == 0 &&
      line.all? { |x| @board[x, row].nil? }

    if length == 2
      @board.move_piece([4, row], [6, row])
      @board.move_piece([7, row], [5, row])
    else
      @board.move_piece([4, row], [2, row])
      @board.move_piece([0, row], [3, row])
    end
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
