require_relative 'card'
require_relative 'deck'

class Hand
  ARR = [:high_card?,
         :one_pair?,
         :two_pair?,
         :three_of_a_kind?,
         :straight?,
         :flush?,
         :full_house?,
         :four_of_a_kind?,
         :straight_flush? ]

  attr_accessor :hand, :deck
  def initialize(deck)
    @deck = deck
    @hand = deck.remove_cards(5)
  end

  def flush?
    suit = hand[0].suit
    hand.all? { |card| card.suit == suit}
  end

  def straight?
    all_straights = Card::VALUE_STRINGS.values.sort.each_cons(5).to_a
    values_in_hand = hand.map { |card| card.value }

    # all_straights needs to be fixed
    !all_straights.include?(values_in_hand.sort)
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    hash_counter = Hash.new(0)
    hand.each do |card|
      hash_counter[card.value] += 1
    end
    hash_counter.values.include?(4)
  end

  def three_of_a_kind?
    hash_counter = Hash.new(0)
    hand.each do |card|
      hash_counter[card.value] += 1
    end
    hash_counter.values.include?(3)
  end

  def full_house?
    hash_counter = Hash.new(0)
    hand.each do |card|
      hash_counter[card.value] += 1
    end
    hash_counter.values.sort == [2, 3]
  end

  def two_pair?
    hash_counter = Hash.new(0)
    hand.each do |card|
      hash_counter[card.value] += 1
    end
    hash_counter.values.sort.drop(1) == [2, 2]
  end

  def one_pair?
    hash_counter = Hash.new(0)
    hand.each do |card|
      hash_counter[card.value] += 1
    end
    hash_counter.values.include?(2)
  end

  def high_card?
    # return false if straight?

    hash_counter = Hash.new(0)
    hand.each do |card|
      hash_counter[card.value] += 1
    end
    self.straight? ? false : hash_counter.values.length == 5
  end

  def beats?(opponent_hand)
    opponent_value = []
    my_value = []
    Hand::ARR.each_with_index do |x, i|
      my_value = [i, x] if self.send(x)
      opponent_value = [i, x] if opponent_hand.send(x)
    end
    case my_value.first <=> opponent_value.first
    when -1; false
    when 1; true
      # look at solution
    # when 0
    #   case my_value.first
    #   when :high_card?
    #     case hand.max { |card| card.value } <=>  opponent_hand.hand.max { |card| card.value }
    #     when -1; false
    #     when 1; true
    #     when 0; false
    #     end
    #
    #   when :one_pair?
    #   when :two_pair?
    #   when :three_of_a_kind?
    #   when :straight?
    #   when :flush?
    #   when :full_house?
    #   when :four_of_a_kind?
    #   when :straight_flush?
    #   end
    end
  end



end
