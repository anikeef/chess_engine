require "./lib/board.rb"
require "./lib/player.rb"

class Game

  def initialize
    @board = Board.new
    @board.set_default
    @players = [Player.new(:white), Player.new(:black)]
    @players_cycle = @players.cycle
    @current_player = @players_cycle.next
  end

  def make_step(from, to)
    chesspiece = @board.at(from)
    raise IncorrectInput, "Empty square is chosen" if chesspiece.nil?
    raise IncorrectInput, "This is not your piece" unless chesspiece.color == @current_player.color

    valid_moves = chesspiece.valid_moves
    raise IncorrectInput, "Invalid move" unless valid_moves.include?(to)

    @board.move_piece(from, to)
  end
end
