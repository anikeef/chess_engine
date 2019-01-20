require "./lib/chesspiece.rb"

describe ChessPiece do
  describe "#fatal_move?" do
    before(:each) do
      @board = Board.new
      @board.set_default
    end

    it "doesn't affect the board" do
      @board[4, 1].fatal_move?([5, 1])
      @board[1, 0].fatal_move?([2, 2])
      @board[4, 0].fatal_move?([4, 5])
      expect(@board.to_s).to eq("8 \e[0;39;49m♜ \e[0m\e[0;39;107m♞ \e[0m\e[0;39;49m▲ \e[0m\e[0;39;107m♛ \e[0m\e[0;39;49m♚ \e[0m\e[0;39;107m▲ \e[0m\e[0;39;49m♞ \e[0m\e[0;39;107m♜ \e[0m\n7 \e[0;39;107m♟ \e[0m\e[0;39;49m♟ \e[0m\e[0;39;107m♟ \e[0m\e[0;39;49m♟ \e[0m\e[0;39;107m♟ \e[0m\e[0;39;49m♟ \e[0m\e[0;39;107m♟ \e[0m\e[0;39;49m♟ \e[0m\n6 \e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\n5 \e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\n4 \e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\n3 \e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\n2 \e[0;39;49m♙ \e[0m\e[0;39;107m♙ \e[0m\e[0;39;49m♙ \e[0m\e[0;39;107m♙ \e[0m\e[0;39;49m♙ \e[0m\e[0;39;107m♙ \e[0m\e[0;39;49m♙ \e[0m\e[0;39;107m♙ \e[0m\n1 \e[0;39;107m♖ \e[0m\e[0;39;49m♘ \e[0m\e[0;39;107m△ \e[0m\e[0;39;49m♕ \e[0m\e[0;39;107m♔ \e[0m\e[0;39;49m△ \e[0m\e[0;39;107m♘ \e[0m\e[0;39;49m♖ \e[0m\n  a b c d e f g h" )
    end

    context "white piece" do
      it "returns false if move is safe" do
        expect(@board[4, 1].fatal_move?([4, 3])).to eq(false)
      end

      it "returns true if move is fatal" do
        @board.move_piece([5, 7], [7, 3])
        expect(@board[5, 1].fatal_move?([5, 2])).to eq(true)
      end
    end

    context "black piece" do
      it "returns false if move is safe" do
        expect(@board[1, 7].fatal_move?([2, 5])).to eq(false)
      end

      it "returns true if move is fatal" do
        @board.move_piece([3, 0], [4, 2])
        expect(@board[4, 6].fatal_move?([3, 5])).to eq(true)
      end
    end
  end
end
