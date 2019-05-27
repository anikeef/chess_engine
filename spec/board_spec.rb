require "./lib/chess_engine/board.rb"

describe ChessEngine::Board do
  before(:each) do
    @board = ChessEngine::Board.new
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
    before(:each) do
      @board.set_default
      @board.move_piece([4, 1], [4, 3])
    end

    it "moves piece between two points" do
      expect(@board.at([4, 1])).to be_nil
      expect(@board.at([4, 3]).pawn?).to eq(true)
    end
  end

  describe "#exists_at?" do
    it "returns true on valid positions" do
      coords = []
      (0..7).to_a.each { |x| coords += (0..7).to_a.map { |y| [x, y] } }
      coords.each do |coords|
        expect(@board.exists_at?(coords)).to eq(true)
      end
    end

    it "returns false on negative values" do
      [[-1, 5], [0, -2], [-1, 0], [-1, -1]].each do |coords|
        expect(@board.exists_at?(coords)).to eq(false)
      end
    end

    it "returns false on too big values" do
      [[0, 8], [8, 3], [-1, 9], [8, 8]].each do |coords|
        expect(@board.exists_at?(coords)).to eq(false)
      end
    end
  end
end
