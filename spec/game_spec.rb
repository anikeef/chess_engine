require "./lib/game.rb"

describe Game do
  before :each do
    @game = Game.new
  end

  describe "#make_move" do
    it "raises an error if the empty square is chosen" do
      expect { @game.make_move([4, 2], [4, 3]) }.to raise_error(IncorrectInput, "Empty square is chosen")
    end

    it "raises an error if a player choses not his own piece" do
      expect { @game.make_move([2, 6], [2, 5]) }.to raise_error(IncorrectInput, "This is not your piece")
    end

    it "raises an error if invalid move is made" do
      expect { @game.make_move([4, 1], [4, 4]) }.to raise_error(IncorrectInput, "Invalid move")
    end

    it "makes correct moves" do
      @game.make_move([4, 1], [4, 3])
      expect(@game.instance_variable_get(:@board)[4, 3]).to be_a(Pawn)
      expect(@game.instance_variable_get(:@board)[4, 1]).to be_nil
    end
  end

  describe "#play" do
    before(:each) do
      $stdout = StringIO.new
    end

    it "plays until the mate" do
      allow_any_instance_of(Player).to receive(:gets).and_return("f2f3", "e7e6", "g2g4", "d8h4")
      expect { @game.play }.to output(/.*White player got mated!$/).to_stdout
    end

    it "plays with the en passant" do
      allow_any_instance_of(Player).to receive(:gets).and_return("e2e4", "a7a6", "e4e5", "f7f5", "e5f6", "exit")
      @game.play
      expect(@game.instance_variable_get(:@board)[5, 5]).to be_a(Pawn)
      expect(@game.instance_variable_get(:@board)[5, 4]).to be_nil
    end

    it "plays with the promotion" do
      allow_any_instance_of(Player).to receive(:gets).and_return("g2g4", "h7h5", "g1f3", "h5g4", "h2h4", "g4g3", "f1h3", "g3g2", "h1h2", "g2g1", "1", "exit")
      @game.play
      expect(@game.instance_variable_get(:@board)[6, 0]).to be_a(Queen)
    end
  end
end
