require "./lib/game.rb"

describe Game do
  before :each do
    @game = Game.new
  end

  describe "#make_step" do
    it "raises an error if the empty square is chosen" do
      expect { @game.make_step([4, 2], [4, 3]) }.to raise_error(IncorrectInput, "Empty square is chosen")
    end

    it "raises an error if a player choses not his own piece" do
      expect { @game.make_step([2, 6], [2, 5]) }.to raise_error(IncorrectInput, "This is not your piece")
    end

    it "raises an error if illegal step is made" do
      chosen_piece = double("chosen_piece", :valid_moves => [[4, 2], [4, 3]], :color => :white)
      @game.instance_variable_get(:@board)[4, 1] = chosen_piece
      expect { @game.make_step([4, 1], [4, 4]) }.to raise_error(IncorrectInput, "Invalid move")
    end

    it "makes correct steps" do
      @game.make_step([4, 1], [4, 3])
      expect(@game.instance_variable_get(:@board)[4, 3]).to be_a(Pawn)
      expect(@game.instance_variable_get(:@board)[4, 1]).to be_nil
    end
  end
end
