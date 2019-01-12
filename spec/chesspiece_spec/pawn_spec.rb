require "./lib/chesspiece/pawn.rb"

describe Pawn do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Pawn.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("♟")
      expect(Pawn.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("♙")
    end
  end

  describe "#valid_moves" do
    before(:each) do
      @board = Board.new
      @board.set_default
    end

    context "white piece" do
      it "returns valid moves in initial position" do
        expect(@board["a2"].valid_moves).to eq(["a3", "a4"])
      end

      it "captures diagonally" do
        @board["c6"] = Pawn.new(:white, @board, "c6")
        expect(@board["c6"].valid_moves).to eq(["c7", "b7", "d7"])
      end

      it "returns valid moves from the middle of the board" do
        @board["c4"] = Pawn.new(:white, @board, "c4")
        @board["c4"].moves = 1
        expect(@board["c4"].valid_moves).to eq(["c5"])
      end

      it "returns valid moves from the edge of the board" do
        @board["a6"] = Pawn.new(:white, @board, "a6")
        expect(@board["a6"].valid_moves).to eq(["a7", "b7"])
      end
    end

    context "black piece" do
      it "returns valid moves in initial position" do
        expect(@board["a7"].valid_moves).to eq(["a6", "a5"])
      end

      it "captures diagonally" do
        @board["c3"] = Pawn.new(:black, @board, "c3")
        expect(@board["c3"].valid_moves).to eq(["c2", "b2", "d2"])
      end

      it "returns valid moves from the middle of the board" do
        @board["c5"] = Pawn.new(:black, @board, "c5")
        @board["c5"].moves = 1
        expect(@board["c5"].valid_moves).to eq(["c4"])
      end

      it "returns valid moves from the edge of the board" do
        @board["a3"] = Pawn.new(:black, @board, "a3")
        expect(@board["a3"].valid_moves).to eq(["a2", "b2"])
      end
    end
  end
end
