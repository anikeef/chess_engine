require "./lib/chesspiece/queen.rb"

describe Queen do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Queen.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("♛")
      expect(Queen.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("♕")
    end
  end

  describe "#valid_moves" do
    before(:each) do
      @board = Board.new
      @board.set_default
    end

    it "returns empty array in initial position" do
      expect(@board[3, 0].valid_moves).to eq([])
    end

    it "returns valid moves from the middle of the board" do
      @board[3, 3] = Queen.new(:white, @board, [3, 3])
      expect(@board[3, 3].valid_moves).to contain_exactly([3, 4], [3, 5], [3, 6], [3, 2], [4, 3], [5, 3], [6, 3], [7, 3], [4, 2], [4, 4], [5, 5], [6, 6], [2, 3], [1, 3], [0, 3], [2, 4], [1, 5], [0, 6], [2, 2])
    end
  end
end
