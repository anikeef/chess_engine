require "./lib/chesspiece/knight.rb"

describe Knight do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Knight.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("♞")
      expect(Knight.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("♘")
    end
  end

  describe "#valid_moves" do
    before(:each) do
      @board = Board.new
      @board.set_default
    end

    it "returns valid moves in initial position" do
      expect(@board[1, 0].valid_moves).to contain_exactly([2, 2], [0, 2])
      expect(@board[6, 7].valid_moves).to contain_exactly([5, 5], [7, 5])
    end

    it "returns valid moves from the middle of the board" do
      @board[3, 4] = Knight.new(:white, @board, [3, 4])
      expect(@board[3, 4].valid_moves).to contain_exactly([1, 5], [2, 6], [4, 6], [5, 5], [5, 3], [1, 3], [2, 2], [4, 2])
    end

    it "returns valid moves from outside positions" do
      @board[7, 2] = Knight.new(:black, @board, [7, 2])
      expect(@board[7, 2].valid_moves).to contain_exactly([6, 0], [6, 4], [5, 3], [5, 1])
    end

    it "doesn't include fatal moves" do
      @board[7, 3] = Elephant.new(:black, @board, [7, 3])
      @board[5, 1] = Knight.new(:white, @board, [5,1])
      expect(@board[5, 1].valid_moves).to eq([])
    end
  end
end
