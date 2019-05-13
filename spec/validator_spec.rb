require "./lib/chess/game.rb"

describe Chess::MoveValidator do
  before(:each) do
    @game = Chess::Game.new
  end

  it "validates pawn moves" do
    @game.instance_variable_get(:@board).set_at([1, 2], Chess::Pawn.new(:black))
    expect(@game.valid_moves([2, 1])).to contain_exactly([1, 2], [2, 2], [2, 3])
  end

  it "validates knight moves" do
    @game.instance_variable_get(:@board).set_at([2, 4], Chess::Knight.new(:white))
    expect(@game.valid_moves([2, 4])).to contain_exactly(
      [0, 3], [1, 2], [3, 2], [4, 3], [0, 5], [1, 6], [3, 6], [4, 5]
    )
  end

  it "validates elephant moves" do
    @game.instance_variable_get(:@board).set_at([2, 4], Chess::Elephant.new(:white))
    expect(@game.valid_moves([2, 4])).to contain_exactly(
      [0, 2], [1, 3], [3, 5], [4, 6], [0, 6], [1, 5], [3, 3], [4, 2]
    )
  end
end
