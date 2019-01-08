require "./lib/game.rb"

describe Game do
  before :each do
    @game = Game.new
  end

  describe "#make_step" do
    it "raises an error if the empty square is chosen" do
      expect { @game.make_step("e3", "e4") }.to raise_error(IncorrectInput, "Empty square is chosen")
    end

    it "raises an error if a player choses not his own piece" do
      expect { @game.make_step("a7", "a6") }.to raise_error(IncorrectInput, "This is not your piece")
    end

    it "raises an error if illegal step is made" do
      chosen_piece = double("chosen_piece", :get_allowed_moves => ["e3", "e4"], :color => :white)
      @game.instance_variable_set(:@board, {"e2" => chosen_piece})
      expect { @game.make_step("e2", "e5") }.to raise_error(IncorrectInput, "Illegal step")
    end

    it "raises an error if the target square is taken by a piece with the same color" do
      chosen_piece = double("chosen_piece", :color => :white, :get_allowed_moves => ["e3", "e4"])
      target_piece = double("target_piece", :color => :white)
      @game.instance_variable_set(:@board, {"e2" => chosen_piece, "e4" => target_piece})
      expect { @game.make_step("e2", "e4") }.to raise_error(IncorrectInput, "You can't beat your own piece")
    end

    it "makes correct steps" do
      chosen_piece = double("chosen_piece", :color => :white, :get_allowed_moves => ["e3", "e4"])
      board = @game.instance_variable_get(:@board)
      board["e2"] = chosen_piece
      @game.instance_variable_set(:@board, board)
      @game.make_step("e2", "e4")
      expect(@game.instance_variable_get(:@board)["e4"]).to eq(chosen_piece)
      expect(@game.instance_variable_get(:@board)["e2"]).to be_nil
    end
  end
end
