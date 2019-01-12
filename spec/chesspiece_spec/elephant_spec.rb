require "./lib/chesspiece/elephant.rb"

describe Elephant do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Elephant.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("▲")
      expect(Elephant.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("△")
    end
  end

  describe "#allowed_moves" do
    it "returns empty array in initial position" do
      b = Board.new
      b.set_default
      expect(b["c8"].allowed_moves).to eq([])
    end

    it "returns allowed moves from the middle of the board" do
      b = Board.new
      b.set_default
      b["d4"] = Elephant.new(:white, b, "d4")
      expect(b["d4"].allowed_moves).to eq(["e5", "f6", "g7", "c3", "c5", "b6", "a7", "e3"])
    end
  end
end
