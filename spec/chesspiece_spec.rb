require "./lib/chesspiece.rb"

describe Pawn do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Pawn.new(:black).instance_variable_get(:@symbol)).to eq("♟")
      expect(Pawn.new(:white).instance_variable_get(:@symbol)).to eq("♙")
    end
  end
end

describe Rook do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Rook.new(:black).instance_variable_get(:@symbol)).to eq("♜")
      expect(Rook.new(:white).instance_variable_get(:@symbol)).to eq("♖")
    end
  end
end

describe Knight do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Knight.new(:black).instance_variable_get(:@symbol)).to eq("♞")
      expect(Knight.new(:white).instance_variable_get(:@symbol)).to eq("♘")
    end
  end
end

describe Elephant do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Elephant.new(:black).instance_variable_get(:@symbol)).to eq("♝")
      expect(Elephant.new(:white).instance_variable_get(:@symbol)).to eq("♗")
    end
  end
end

describe King do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(King.new(:black).instance_variable_get(:@symbol)).to eq("♚")
      expect(King.new(:white).instance_variable_get(:@symbol)).to eq("♔")
    end
  end
end

describe Queen do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Queen.new(:black).instance_variable_get(:@symbol)).to eq("♛")
      expect(Queen.new(:white).instance_variable_get(:@symbol)).to eq("♕")
    end
  end
end
