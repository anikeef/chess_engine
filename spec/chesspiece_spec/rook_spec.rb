require "./lib/chesspiece/rook.rb"

describe Rook do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Rook.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("♜")
      expect(Rook.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("♖")
    end
  end

  describe "#valid_moves" do
    before(:each) do
      @board = Board.new
      @board.set_default
    end

    it "returns empty array in initial position" do
      expect(@board[0, 0].valid_moves).to eq([])
    end

    it "returns valid moves from the middle of the board" do
      @board[3, 3] = Rook.new(:black, @board, [3, 3])
      expect(@board[3, 3].valid_moves).to contain_exactly([3, 4], [3, 5], [3, 2], [3, 1], [4, 3], [5, 3], [6, 3], [7, 3], [2, 3], [1, 3], [0, 3])
    end
  end
end
