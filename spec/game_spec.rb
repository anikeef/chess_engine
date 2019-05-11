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
      expect(@game.board[4, 3]).to be_a(Pawn)
      expect(@game.board[4, 1]).to be_nil
    end

    it "makes en passant" do
      @game.make_move([0, 1], [0, 3])
      @game.make_move([7, 6], [7, 4])
      @game.make_move([0, 3], [0, 4])
      @game.make_move([1, 6], [1, 4])
      @game.make_move([0, 4], [1, 5])
      expect(@game.board[0, 4]).to be_nil
      expect(@game.board[1, 4]).to be_nil
      expect(@game.board[1, 5]).to be_a(Pawn)
      expect(@game.board[1, 5].color).to eq(:white)
    end
  end


  # describe "#play" do
  #   before(:each) do
  #     $stdout = StringIO.new
  #   end
  #
  #   it "plays until the checkmate" do
  #     allow_any_instance_of(Player).to receive(:gets).and_return("f2f3", "e7e6", "g2g4", "d8h4")
  #     expect { @game.play }.to output(/.*White player got mated!$/).to_stdout
  #   end
  #
  #   it "plays with the en passant" do
  #     allow_any_instance_of(Player).to receive(:gets).and_return("e2e4", "a7a6", "e4e5", "f7f5", "e5f6", "exit")
  #     @game.play
  #     expect(@game.instance_variable_get(:@board)[5, 5]).to be_a(Pawn)
  #     expect(@game.instance_variable_get(:@board)[5, 4]).to be_nil
  #   end
  #
  #   it "plays with the promotion" do
  #     allow_any_instance_of(Player).to receive(:gets).and_return("g2g4", "h7h5", "g1f3", "h5g4", "h2h4", "g4g3", "f1h3", "g3g2", "h1h2", "g2g1", "1", "exit")
  #     @game.play
  #     expect(@game.instance_variable_get(:@board)[6, 0]).to be_a(Queen)
  #   end
  #
  #   it "plays with the castling" do
  #     allow_any_instance_of(Player).to receive(:gets).and_return("g1f3", "b8a6", "g2g3", "b7b6", "f1g2", "c8b7", "h2h3", "c7c6", "00", "d8c7", "h3h4", "ooo", "exit")
  #     @game.play
  #     expect(@game.instance_variable_get(:@board)[6, 0]).to be_a(King)
  #     expect(@game.instance_variable_get(:@board)[5, 0]).to be_a(Rook)
  #     expect(@game.instance_variable_get(:@board)[2, 7]).to be_a(King)
  #     expect(@game.instance_variable_get(:@board)[3, 7]).to be_a(Rook)
  #   end
  # end
end
