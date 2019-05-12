def execute_game(moves)
  moves.each do |move|
    @game.move(move)
  end
end
