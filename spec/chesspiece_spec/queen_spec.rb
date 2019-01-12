require "./lib/chesspiece/queen.rb"

describe Queen do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Queen.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("♛")
      expect(Queen.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("♕")
    end
  end

  describe "#allowed_moves" do
    it "returns empty array in initial position" do
      b = Board.new
      b.set_default
      expect(b["d1"].allowed_moves).to eq([])
    end

    it "returns allowed moves from the middle of the board" do
      b = Board.new
      b.set_default
      b["d4"] = Queen.new(:white, b, "d4")
      expect(b["d4"].allowed_moves).to eq(["c4", "b4", "a4", "e4", "f4", "g4", "h4", "d5", "d6", "d7", "d3","e5", "f6", "g7", "c3", "c5", "b6", "a7", "e3"])
    end
  end
end
