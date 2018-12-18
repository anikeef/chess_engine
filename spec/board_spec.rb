require "./lib/board.rb"

describe Board do
  describe "#initialize" do
    it "creates empty board" do
      b = Board.new
      expect(b.instance_variable_get(:@board)).to eq(
        {"a8"=>nil, "b8"=>nil, "c8"=>nil, "d8"=>nil, "e8"=>nil, "f8"=>nil, "g8"=>nil, "h8"=>nil,
         "a7"=>nil, "b7"=>nil, "c7"=>nil, "d7"=>nil, "e7"=>nil, "f7"=>nil, "g7"=>nil, "h7"=>nil,
         "a6"=>nil, "b6"=>nil, "c6"=>nil, "d6"=>nil, "e6"=>nil, "f6"=>nil, "g6"=>nil, "h6"=>nil,
         "a5"=>nil, "b5"=>nil, "c5"=>nil, "d5"=>nil, "e5"=>nil, "f5"=>nil, "g5"=>nil, "h5"=>nil,
         "a4"=>nil, "b4"=>nil, "c4"=>nil, "d4"=>nil, "e4"=>nil, "f4"=>nil, "g4"=>nil, "h4"=>nil,
         "a3"=>nil, "b3"=>nil, "c3"=>nil, "d3"=>nil, "e3"=>nil, "f3"=>nil, "g3"=>nil, "h3"=>nil,
         "a2"=>nil, "b2"=>nil, "c2"=>nil, "d2"=>nil, "e2"=>nil, "f2"=>nil, "g2"=>nil, "h2"=>nil,
         "a1"=>nil, "b1"=>nil, "c1"=>nil, "d1"=>nil, "e1"=>nil, "f1"=>nil, "g1"=>nil, "h1"=>nil})
    end
  end
end
