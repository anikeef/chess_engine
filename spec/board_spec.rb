require "./lib/board.rb"

describe Board do
  before(:each) do
    @board = Board.new
  end

  describe "#initialize" do
    it "creates empty board" do
      expect(@board.instance_variable_get(:@board)).to eq(
        [[nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil, nil]])
    end
  end

  describe "#to_s" do
    it "converts empty board into string" do
      expect(@board.to_s).to eq(
        "8 \e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\n7 \e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\n6 \e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\n5 \e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\n4 \e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\n3 \e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\n2 \e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\n1 \e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\n  a b c d e f g h"
      )
    end

    it "converts default board into string" do
      @board.set_default
      expect(@board.to_s).to eq(
        "8 \e[0;39;49m♜ \e[0m\e[0;39;107m♞ \e[0m\e[0;39;49m▲ \e[0m\e[0;39;107m♛ \e[0m\e[0;39;49m♚ \e[0m\e[0;39;107m▲ \e[0m\e[0;39;49m♞ \e[0m\e[0;39;107m♜ \e[0m\n7 \e[0;39;107m♟ \e[0m\e[0;39;49m♟ \e[0m\e[0;39;107m♟ \e[0m\e[0;39;49m♟ \e[0m\e[0;39;107m♟ \e[0m\e[0;39;49m♟ \e[0m\e[0;39;107m♟ \e[0m\e[0;39;49m♟ \e[0m\n6 \e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\n5 \e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\n4 \e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\n3 \e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\e[0;39;107m  \e[0m\e[0;39;49m  \e[0m\n2 \e[0;39;49m♙ \e[0m\e[0;39;107m♙ \e[0m\e[0;39;49m♙ \e[0m\e[0;39;107m♙ \e[0m\e[0;39;49m♙ \e[0m\e[0;39;107m♙ \e[0m\e[0;39;49m♙ \e[0m\e[0;39;107m♙ \e[0m\n1 \e[0;39;107m♖ \e[0m\e[0;39;49m♘ \e[0m\e[0;39;107m△ \e[0m\e[0;39;49m♕ \e[0m\e[0;39;107m♔ \e[0m\e[0;39;49m△ \e[0m\e[0;39;107m♘ \e[0m\e[0;39;49m♖ \e[0m\n  a b c d e f g h"
      )
    end
  end

  describe "#move_piece" do
    it "moves piece between two points" do
      @board.set_default
      @board.move_piece([4, 1], [4, 3])
      expect(@board[4, 1]).to be_nil
      expect(@board[4, 3]).to be_a Pawn
    end
  end
end
