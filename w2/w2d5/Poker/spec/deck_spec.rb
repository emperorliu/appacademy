require 'deck'
require 'rspec'

describe Deck do
  subject(:deck) { Deck.new }

  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards }

    it "starts with a count of 52" do
      expect(all_cards.count).to eq(52)
    end
  end

  describe '#count' do

    it "can access instance variable cards" do
      expect(deck.count).to eq(52)
    end
  end

  describe '#remove_cards' do

    it 'removes top n cards' do
      deck.remove_cards(4)
      expect(deck.count).to eq(48)
    end

    it "can't take more cards than there are in deck" do
      expect { deck.remove_cards(54) }.to raise_error("Not enough cards in deck")
    end
  end

end
