class Player
  attr_reader :name
  attr_accessor :hand
  def initialize(name, bankroll, hand)
    @hand = hand
    @name = name
    @bet = 0
    @bankroll = bankroll
  end

  def discard(arr)
    arr.each do |card|
      self.hand.delete(card)
    end
  end

end
