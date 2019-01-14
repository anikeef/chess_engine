require "./lib/chesspiece/king.rb"

describe King do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(King.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("♚")
      expect(King.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("♔")
    end
  end

  describe "#valid_moves" do
    before(:each) do
      @board = Board.new
      @board.set_default
    end

    it "returns empty array in initial position" do
      expect(@board[4, 0].valid_moves).to eq([])
    end

    it "returns valid moves from the middle of the board" do
      @board[3, 3] = King.new(:white, @board, [3, 3])
      expect(@board[3, 3].valid_moves).to contain_exactly([2, 2], [2, 3], [2, 4], [3, 2], [3, 4], [4, 2], [4, 3], [4, 4])
    end
  end
end
