require "./lib/board.rb"

class Game

  def initialize
    @board = Board.new
    @board.set_default
    @players = [Player.new(:white), Player.new(:black)]
  end
end
