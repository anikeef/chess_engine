require "./lib/chesspiece/pawn.rb"

describe Pawn do
  describe "#initialize" do
    it "stores correct symbol" do
      expect(Pawn.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("♟")
      expect(Pawn.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("♙")
    end
  end

  describe "#valid_moves" do
    before(:each) do
      @board = Board.new
      @board.set_default
    end

    context "white piece" do
      it "returns valid moves in initial position" do
        expect(@board[2, 1].valid_moves).to contain_exactly([2, 2], [2, 3])
      end

      it "captures diagonally" do
        pawn = Pawn.new(:white, @board, [2, 5])
        expect(pawn.valid_moves).to contain_exactly([2, 6], [1, 6], [3, 6])
      end

      it "returns valid moves from the middle of the board" do
        pawn = Pawn.new(:white, @board, [2, 3])
        pawn.moves = 1
        expect(pawn.valid_moves).to eq([[2, 4]])
      end

      it "returns valid moves from the edge of the board" do
        pawn = Pawn.new(:white, @board, [0, 5])
        expect(pawn.valid_moves).to contain_exactly([0, 6], [1, 6])
      end
    end

    context "black piece" do
      it "returns valid moves in initial position" do
        expect(@board[0, 6].valid_moves).to contain_exactly([0, 5], [0, 4])
      end

      it "captures diagonally" do
        pawn = Pawn.new(:black, @board, [2, 2])
        expect(pawn.valid_moves).to contain_exactly([1, 1], [2, 1], [3, 1])
      end

      it "returns valid moves from the middle of the board" do
        pawn = Pawn.new(:black, @board, [2, 4])
        pawn.moves = 1
        expect(pawn.valid_moves).to eq([[2, 3]])
      end

      it "returns valid moves from the edge of the board" do
        pawn = Pawn.new(:black, @board, [0, 2])
        expect(pawn.valid_moves).to contain_exactly([0, 1], [1, 1])
      end
    end
  end
end
