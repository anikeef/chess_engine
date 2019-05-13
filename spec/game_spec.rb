require "./lib/game.rb"
require "./spec/game_helper.rb"

describe Game do
  before :each do
    @game = Game.new
  end

  describe "#move" do
    it "raises an error if the empty square is chosen" do
      expect { @game.move("e3e4") }.to raise_error(IncorrectInput, "Empty square is chosen")
    end

    it "raises an error if a player choses not his own piece" do
      expect { @game.move("c7c6") }.to raise_error(IncorrectInput, "This is not your piece")
    end

    it "raises an error if invalid move is made" do
      expect { @game.move("e2e5") }.to raise_error(IncorrectInput, "Invalid move")
    end

    it "raises an error if the move is fatal" do

      execute_game(%w{a2a3 e7e6 a3a4 d8h4})
      expect { @game.move("f2f3") }.to raise_error(IncorrectInput, "Fatal move")
    end

    it "makes correct moves" do
      @game.move("e2e4")
      expect(@game["e4"]).to be_a(Pawn)
      expect(@game["e2"]).to be_nil
    end

    it "makes en passant" do
      execute_game(%w{a2a4 h7h5 a4a5 b7b5 a5b6})
      expect(@game["a5"]).to be_nil
      expect(@game["b5"]).to be_nil
      expect(@game["b6"]).to be_a(Pawn)
      expect(@game["b6"].color).to eq(:white)
    end
  end


  describe "#over?" do
    it "recognizes the checkmate" do
      execute_game(%w{f2f3 e7e6 g2g4 d8h4})
      expect @game.over?
    end
  end

  describe "#castling" do
    it "plays with short and long castling" do
      execute_game(%w{g1f3 b8a6 g2g3 b7b6 f1g2 c8b7 h2h3 c7c6})
      @game.castling(:short)
      expect(@game["g1"].king?).to eq(true)
      expect(@game["f1"].rook?).to eq(true)
      execute_game(%w{d8c7 h3h4})
      @game.castling(:long)
      expect(@game["c8"].king?).to eq(true)
      expect(@game["d8"].rook?).to eq(true)
    end
  end

  describe "#promotion" do
    it "plays with promotion" do
      expect(@game.needs_promotion?).to eq(false)
      execute_game(%w{g2g4 h7h5 g1f3 h5g4 h2h4 g4g3 f1h3 g3g2 h1h2 g2g1})
      expect(@game.needs_promotion?).to eq(true)
      expect(@game.current_color).to eq(:black)
      expect { @game.move("e2e4") }.to raise_error(IncorrectInput)
      puts @game.draw
      @game.promotion("Queen")
      puts @game.draw
      expect(@game["g1"].queen?).to eq(true)
      expect(@game["g1"].color).to eq(:black)
    end
  end

  #   it "plays with the promotion" do
  #     allow_any_instance_of(Player).to receive(:gets).and_return("g2g4", "h7h5", "g1f3", "h5g4", "h2h4", "g4g3", "f1h3", "g3g2", "h1h2", "g2g1", "1", "exit")
  #     @game.play
  #     expect(@game.instance_variable_get(:@board)[6, 0]).to be_a(Queen)
  #   end
end
