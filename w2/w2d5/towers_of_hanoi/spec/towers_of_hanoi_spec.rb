require 'towers_of_hanoi'

describe TowersOfHanoi do
  subject(:game) { TowersOfHanoi.new }

  it 'should initialize with 3 towers' do
    expect(game.towers.class).to eq(Hash)
    expect(game.towers.length).to eq(3)
    expect(game.towers.values).to eq([[3, 2, 1], [], []])
  end

  describe '#move' do
    it 'should move a disk from one tower to another' do
      game.move(1, 3)

      expect(game.towers[1].length).to eq(2)
      expect(game.towers[2].length).to eq(0)
      expect(game.towers[3].length).to eq(1)
    end

    it 'should not move bigger disk onto a smaller one' do
      game.move(1, 3)
      # expect { raise "Illegal move" }.to raise_error
      expect { game.move(1, 3) }.to raise_error("Illegal move")
    end
  end

  # it 'prompts user for input' do
  #   expect(Kernel).to receive(:gets)
  #   game.from_tower
  # end

end
