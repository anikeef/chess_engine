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
end
