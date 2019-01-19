require "./lib/player.rb"

describe Player do
  before(:each) do
    $stdout = StringIO.new
    @player = Player.new(:white)
  end

  describe "#input_step" do
    it "raises error if the input is invalid" do
      allow(@player).to receive(:gets).and_return("a0b1")
      expect { @player.input_step }.to raise_error(IncorrectInput)
    end

    it "returns proper arrays for correct inputs" do
      allow(@player).to receive(:gets).and_return("e2e4")
      expect(@player.input_step).to eq([[4, 1], [4, 3]])
    end

    it "reads inputs with space characters" do
      allow(@player).to receive(:gets).and_return(" a1   h8 ")
      expect(@player.input_step).to eq([[0, 0], [7, 7]])
    end
  end

  describe "#input_promotion" do
    it "raises error if the input is not between 1 and 4" do
      allow(@player).to receive(:gets).and_return("5")
      expect { @player.input_promotion }.to raise_error(IncorrectInput)
    end

    it "returns a number" do
      allow(@player).to receive(:gets).and_return(" 2  ")
      expect(@player.input_promotion).to eq(2)
    end
  end
end
