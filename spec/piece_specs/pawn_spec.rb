require "./lib/pieces/pawn.rb"

describe Pawn do
  before(:each) do
    @board = Board.new
    @board.set_default
  end

  describe "#initialize" do
    it "stores correct symbol" do
      expect(Pawn.new(:black, nil, nil).instance_variable_get(:@symbol)).to eq("♟")
      expect(Pawn.new(:white, nil, nil).instance_variable_get(:@symbol)).to eq("♙")
    end
  end

  describe "#valid_moves" do
    context "white piece" do
      it "returns valid moves in initial position" do
        expect(@board[2, 1].valid_moves).to contain_exactly([2, 2], [2, 3])
      end

      it "captures diagonally" do
        pawn = Pawn.new(:white, @board, [2, 5])
        expect(pawn.valid_moves).to contain_exactly([1, 6], [3, 6])
      end

      it "returns valid moves from the middle of the board" do
        pawn = Pawn.new(:white, @board, [2, 3])
        pawn.moves = 1
        expect(pawn.valid_moves).to eq([[2, 4]])
      end

      it "returns valid moves from the edge of the board" do
        pawn = Pawn.new(:white, @board, [0, 5])
        expect(pawn.valid_moves).to eq([[1, 6]])
      end

      it "doesn't include fatal moves" do
        @board[7, 3] = Elephant.new(:black, @board, [7, 3])
        expect(@board[5, 1].valid_moves).to eq([])
      end
    end

    context "black piece" do
      it "returns valid moves in initial position" do
        expect(@board[0, 6].valid_moves).to contain_exactly([0, 5], [0, 4])
      end

      it "captures diagonally" do
        pawn = Pawn.new(:black, @board, [2, 2])
        expect(pawn.valid_moves).to contain_exactly([1, 1], [3, 1])
      end

      it "returns valid moves from the middle of the board" do
        pawn = Pawn.new(:black, @board, [2, 4])
        pawn.moves = 1
        expect(pawn.valid_moves).to eq([[2, 3]])
      end

      it "returns valid moves from the edge of the board" do
        pawn = Pawn.new(:black, @board, [0, 2])
        expect(pawn.valid_moves).to eq([[1, 1]])
      end

      it "doesn't include fatal moves" do
        @board[7, 4] = Elephant.new(:white, @board, [7, 4])
        expect(@board[5, 6].valid_moves).to eq([])
      end
    end
  end

  describe "#fatal_en_passant?" do
    it "returns false if the move isn't fatal" do
      @board.move_piece([4, 1], [4, 3])
      @board.move_piece([5, 6], [5, 3])
      expect(@board[5, 3].fatal_en_passant?(@board[4, 3], [4, 2])).to eq(false)
    end

    it "returns true if the move is fatal" do
      @board.move_piece([4, 1], [4, 4])
      @board.move_piece([5, 6], [5, 4])
      @board.move_piece([4, 0], [6, 2])
      @board.move_piece([3, 7], [3, 5])
      expect(@board[4, 4].fatal_en_passant?(@board[5, 4], [5, 5])).to eq(true)
    end

    it "doesn't affect the board" do
      @board[4, 1].fatal_en_passant?(@board[0, 6], [4, 3])
      @board[2, 6].fatal_en_passant?(@board[7, 1], [2, 5])
      expect(@board.to_s).to eq("8 \e[0;39;49m♜ \e[0m\e[0;39;107m♞ \e[0m\e[0;39;49m▲ \e[0m\e[0;39;107m♛ \e[0m\e[0;39;49m♚ \e[0m\e[0;39;107m▲ \e[0m\e[0;39;49m♞ \e[0m\e[0;39;107m♜ \e[0m\n7 \e[0;39;107m♟ \e[0m\e[0;39;49m♟ \e[0m\e[0;39;107m♟ \e[0m\e[0;39;49m♟ \e[0m\e[0;39;107m♟ \e[0m\e[0;39;49m♟ \e[0m\e[0;39;107m♟ \e[0m\e[0;39;49m♟ \e[0m\n6 \e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\n5 \e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\n4 \e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\n3 \e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\n2 \e[0;39;49m♙ \e[0m\e[0;39;107m♙ \e[0m\e[0;39;49m♙ \e[0m\e[0;39;107m♙ \e[0m\e[0;39;49m♙ \e[0m\e[0;39;107m♙ \e[0m\e[0;39;49m♙ \e[0m\e[0;39;107m♙ \e[0m\n1 \e[0;39;107m♖ \e[0m\e[0;39;49m♘ \e[0m\e[0;39;107m△ \e[0m\e[0;39;49m♕ \e[0m\e[0;39;107m♔ \e[0m\e[0;39;49m△ \e[0m\e[0;39;107m♘ \e[0m\e[0;39;49m♖ \e[0m\n  a b c d e f g h")
    end
  end

  describe "#en_passant_coordinates" do
    it "returns nil if the pawn isn't on the middle row" do
      @board.move_piece([4, 1], [4, 5])
      @board.move_piece([5, 6], [5, 5])
      expect(@board[4, 5].en_passant_coordinates(@board[5, 5])).to be_nil
    end

    it "returns nil if the last piece isn't a pawn" do
      @board.move_piece([4, 1], [4, 3])
      @board.move_piece([5, 7], [5, 4])
      expect(@board[4, 3].en_passant_coordinates(@board[5, 4])).to be_nil
    end

    it "returns nil if the last piece moved twice" do
      @board.move_piece([4, 6], [4, 3])
      @board.move_piece([5, 1], [5, 3])
      @board[5, 3].moves = 2
      expect(@board[4, 3].en_passant_coordinates(@board[5, 3])).to be_nil
    end

    it "returns move coordinates if the conditions are met" do
      @board.move_piece([4, 6], [4, 3])
      @board.move_piece([5, 1], [5, 3])
      @board[5, 3].moves = 1
      expect(@board[4, 3].en_passant_coordinates(@board[5, 3])).to eq([5, 2])
    end
  end
end
