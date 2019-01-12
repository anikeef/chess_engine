require "./lib/chesspiece/knight.rb"

describe Knight do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Knight.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("♞")
      expect(Knight.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("♘")
    end
  end

  describe "#valid_moves" do
    it "returns valid moves in initial position" do
      b = Board.new
      b.set_default
      expect(b["b1"].valid_moves).to eq(["c3", "a3"])
      expect(b["g8"].valid_moves).to eq(["h6", "f6"])
    end

    it "returns valid moves from the middle of the board" do
      b = Board.new
      b.set_default
      b["d5"] = Knight.new(:white, b, "d5")
      expect(b["d5"].valid_moves).to eq(["e3", "c3", "e7", "c7", "f4", "b4", "f6", "b6"] )
    end

    it "returns valid moves from outside positions" do
      b = Board.new
      b.set_default
      b["h3"] = Knight.new(:black, b, "h3")
      expect(b["h3"].valid_moves).to eq(["g1", "g5", "f2", "f4"])
    end
  end
end
