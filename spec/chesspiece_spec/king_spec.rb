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

  describe "#attacked?" do
    before(:each) do
      @board = Board.new
      @board[2, 1] = King.new(:white, @board, [2, 1])
      @board[5, 6] = King.new(:black, @board, [5, 6])
      @white_king = @board[2, 1]
      @black_king = @board[5, 6]
    end

    it "is false in initial position" do
      @board.set_default
      expect(@board[4, 0].attacked?).to eq(false)
    end

    it "is true even if all moves for attacking piece are fatal" do
      @board[2, 5] = Queen.new(:black, @board, [2, 5])
      @board[0, 5] = Rook.new(:white, @board, [0, 5])
      expect(@white_king.attacked?).to eq(true)
    end

    context "by pawn" do
      it "is false if the pawn is behind the king" do
        @board[3, 0] = Pawn.new(:black, @board, [3, 0])
        @board[6, 7] = Pawn.new(:white, @board, [6, 7])
        expect(@white_king.attacked?).to eq(false)
        expect(@black_king.attacked?).to eq(false)
      end

      it "is false if pawn doesn't attack the king" do
        @board[2, 2] = Pawn.new(:black, @board, [2, 2])
        @board[5, 5] = Pawn.new(:black, @board, [2, 2])
        expect(@white_king.attacked?).to eq(false)
        expect(@black_king.attacked?).to eq(false)
      end

      it "is true if pawn attacks the king" do
        @board[3, 2] = Pawn.new(:black, @board, [3, 2])
        @board[4, 5] = Pawn.new(:white, @board, [4, 5])
        expect(@white_king.attacked?).to eq(true)
        expect(@black_king.attacked?).to eq(true)
      end
    end

    context "by rook" do
      it "is false if rook doesn't attack the king" do
        @board[3, 2] = Rook.new(:black, @board, [3, 2])
        @board[2, 5] = Rook.new(:white, @board, [2, 5])
        expect(@white_king.attacked?).to eq(false)
        expect(@black_king.attacked?).to eq(false)
      end

      it "is true if rook attacks the king" do
        @board[5, 0] = Rook.new(:white, @board, [5, 0])
        @board[3, 1] = Rook.new(:black, @board, [3, 1])
        expect(@white_king.attacked?).to eq(true)
        expect(@black_king.attacked?).to eq(true)
      end
    end

    context "by elephant" do
      it "is false if elephant doesn't attack the king" do
        @board[2, 3] = Elephant.new(:black, @board, [2, 3])
        @board[5, 4] = Elephant.new(:white, @board, [5, 4])
        expect(@white_king.attacked?).to eq(false)
        expect(@black_king.attacked?).to eq(false)
      end

      it "is true if elephant attacks the king" do
        @board[0, 1] = Elephant.new(:white, @board, [0, 1])
        @board[3, 2] = Elephant.new(:black, @board, [3, 2])
        expect(@white_king.attacked?).to eq(true)
        expect(@black_king.attacked?).to eq(true)
      end
    end

    context "by queen" do
      it "is false if queen doesn't attack the king" do
        @board[3, 6] = Queen.new(:black, @board, [3, 6])
        @board[4, 3] = Queen.new(:white, @board, [4, 3])
        expect(@white_king.attacked?).to eq(false)
        expect(@black_king.attacked?).to eq(false)
      end

      it "is true if queen is on the same line" do
        @board[5, 4] = Queen.new(:white, @board, [5, 4])
        @board[4, 1] = Queen.new(:black, @board, [4, 1])
        expect(@white_king.attacked?).to eq(true)
        expect(@black_king.attacked?).to eq(true)
      end

      it "is true if queen attacks diagonally" do
        @board[3, 4] = Queen.new(:white, @board, [3, 4])
        @board[4, 3] = Queen.new(:black, @board, [4, 3])
        expect(@white_king.attacked?).to eq(true)
        expect(@black_king.attacked?).to eq(true)
      end
    end

    context "by knight" do
      it "is false if knight doesn't attack the king" do
        @board[6, 4] = Knight.new(:black, @board, [6, 4])
        @board[5, 4] = Knight.new(:white, @board, [5, 4])
        expect(@white_king.attacked?).to eq(false)
        expect(@black_king.attacked?).to eq(false)
      end

      it "is true if knight attacks the king" do
        @board[4, 4] = Knight.new(:white, @board, [4, 4])
        @board[4, 0] = Knight.new(:black, @board, [4, 0])
        expect(@white_king.attacked?).to eq(true)
        expect(@black_king.attacked?).to eq(true)
      end
    end

    context "by king" do
      it "is false if king doesn't attack the king" do
        expect(@white_king.attacked?).to eq(false)
        expect(@black_king.attacked?).to eq(false)
      end

      it "is true if kings are on the same line" do
        @board[5, 6] = nil
        @board[3, 2] = King.new(:black, @board, [3, 2])
        expect(@white_king.attacked?).to eq(true)
        expect(@board[3, 2].attacked?).to eq(true)
      end

      it "is true if kings are on the same diagonal" do
        @board[5, 6] = nil
        @board[3, 1] = King.new(:black, @board, [3, 1])
        expect(@white_king.attacked?).to eq(true)
        expect(@board[3, 1].attacked?).to eq(true)
      end
    end
  end
end
