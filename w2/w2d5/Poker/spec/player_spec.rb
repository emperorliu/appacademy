# expect(deck).to receive(:remove_cards).with(5).and_return([1, 2, 3, 4, 5])
require 'player'
require_relative '../lib/card.rb'

describe Player do
  let(:hand) { double('hand') }
  subject(:player) { Player.new('Bob', 1000, hand) }
  it "initialize with name" do
    expect(player.name).to eq('Bob')
  end

  describe "#discard" do
    it "should remove given cards from hand" do
      my_hand = [Card.new(:hearts, :seven),
                    Card.new(:hearts, :ace),
                    Card.new(:hearts, :nine),
                    Card.new(:hearts, :three),
                    Card.new(:hearts, :jack)]

      allow(player).to receive(:hand).and_return(my_hand)
      some_card = Card.new(:hearts, :ace)
      player.discard([some_card])

      expect(player.hand.length).to eq(4)
    end
  end


end
