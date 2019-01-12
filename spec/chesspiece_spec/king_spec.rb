require "./lib/chesspiece/king.rb"

describe King do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(King.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("♚")
      expect(King.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("♔")
    end
  end
end
