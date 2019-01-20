require "./lib/pieces/elephant.rb"

describe Elephant do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Elephant.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("▲")
      expect(Elephant.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("△")
    end
  end

  describe "#valid_moves" do
    before(:each) do
      @board = Board.new
      @board.set_default
    end

    it "returns empty array in initial position" do
      expect(@board[2, 0].valid_moves).to eq([])
    end

    it "returns valid moves from the middle of the board" do
      @board[3, 3] = Elephant.new(:white, @board, [3, 3])
      expect(@board[3, 3].valid_moves).to contain_exactly([4, 4], [5, 5], [6, 6], [2, 2], [2, 4], [1, 5], [0, 6], [4, 2])
    end

    it "doesn't include fatal moves" do
      @board[7, 3] = Queen.new(:black, @board, [7, 3])
      @board.move_piece([5, 0], [5, 1])
      expect(@board[5, 1].valid_moves).to contain_exactly([6, 2], [7, 3])
    end
  end
end
