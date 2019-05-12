def execute_game(moves)
  moves.each do |move|
    @game.move(move)
  end
end

def move_from_string(string)
  letters = ("a".."h").to_a
  [[letters.find_index(string[0]), string[1].to_i - 1],
   [letters.find_index(string[2]), string[3].to_i - 1]]
end
