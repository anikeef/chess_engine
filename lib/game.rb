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
    chesspiece = @board[from]
    raise IncorrectInput, "Empty square is chosen" if chesspiece.nil?
    raise IncorrectInput, "This is not your piece" unless chesspiece.color == @current_player.color

    allowed_moves = chesspiece.allowed_moves(from)
    raise IncorrectInput, "Illegal step" unless allowed_moves.include?(to)
    raise IncorrectInput, "You can't beat your own piece" if !@board[to].nil? && @board[to].color == chesspiece.color

    @board.move_piece(from, to)
  end
end
