require "./lib/chesspiece/rook.rb"

describe Rook do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Rook.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("♜")
      expect(Rook.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("♖")
    end
  end

  describe "#valid_moves" do
    it "returns empty array in initial position" do
      b = Board.new
      b.set_default
      expect(b["a1"].valid_moves).to eq([])
    end

    it "returns valid moves from the middle of the board" do
      b = Board.new
      b.set_default
      b["d4"] = Rook.new(:black, b, "d4")
      expect(b["d4"].valid_moves).to eq(["c4", "b4", "a4", "e4", "f4", "g4", "h4", "d5", "d6", "d3", "d2"])
    end
  end
end
