require_relative 'card.rb'

class Deck
  def self.all_cards
    cards_arr =[]
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards_arr << Card.new(suit, value)
      end
    end
    cards_arr.shuffle
  end

  attr_reader :cards
  def initialize
    @cards = Deck.all_cards
  end

  def count
    cards.count
  end

  def remove_cards(num)
    raise "Not enough cards in deck" if num > count
    cards.shift(num)
  end

end
