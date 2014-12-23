require 'hand'


describe Hand do
  let(:deck) { double("deck") }
  subject(:hand) { Hand.new(deck) }


  it "should call remove_cards on deck" do
    expect(deck).to receive(:remove_cards).with(5).and_return([1, 2, 3, 4, 5])
    expect(hand.hand.count).to eq(5)
  end

  describe "#flush?" do
    it "should return true if cards have the same suit" do
      flush = [
        Card.new(:hearts, :seven),
        Card.new(:hearts, :ace),
        Card.new(:hearts, :nine),
        Card.new(:hearts, :three),
        Card.new(:hearts, :jack)
      ].shuffle
      expect(deck).to receive(:remove_cards).with(5).and_return(flush)
      hand.hand = flush
      expect(hand.flush?).to eq(true)

    end
  end

  describe "#straight?" do
    it "should return true if hand is a straight flush" do
      straight = [
        Card.new(:spades, :seven),
        Card.new(:clubs, :eight),
        Card.new(:diamonds, :nine),
        Card.new(:clubs, :ten),
        Card.new(:hearts, :jack)
      ].shuffle
      expect(deck).to receive(:remove_cards).with(5).and_return(straight)
      hand.hand = straight

      expect(hand.straight?).to eq(true)

    end
  end

  describe "#straight_flush?" do
    it "should return true if hand is a straight flush" do
      straight_flush = [
        Card.new(:clubs, :seven),
        Card.new(:clubs, :eight),
        Card.new(:clubs, :nine),
        Card.new(:clubs, :ten),
        Card.new(:clubs, :jack)
      ].shuffle
      expect(deck).to receive(:remove_cards).with(5).and_return(straight_flush)
      hand.hand = straight_flush

      expect(hand.straight_flush?).to eq(true)

    end
  end

  describe "#four_of_a_kind?" do
    it "should return true if hand is a four of a kind" do
      four_of_a_kind = [
        Card.new(:clubs, :seven),
        Card.new(:hearts, :seven),
        Card.new(:diamonds, :seven),
        Card.new(:spades, :seven),
        Card.new(:clubs, :jack)
      ].shuffle
      expect(deck).to receive(:remove_cards).with(5).and_return(four_of_a_kind)
      hand.hand = four_of_a_kind

      expect(hand.four_of_a_kind?).to eq(true)
    end
  end

  describe "#three_of_a_kind?" do
    it "should return true if hand is a three of a kind" do
      three_of_a_kind = [
        Card.new(:clubs, :seven),
        Card.new(:hearts, :seven),
        Card.new(:diamonds, :six),
        Card.new(:spades, :seven),
        Card.new(:clubs, :jack)
      ].shuffle
      expect(deck).to receive(:remove_cards).with(5).and_return(three_of_a_kind)
      hand.hand = three_of_a_kind

      expect(hand.three_of_a_kind?).to eq(true)
    end
  end

  describe "#full_house?" do
    it "should return true if hand is a full house" do
      full_house = [
        Card.new(:clubs, :five),
        Card.new(:hearts, :five),
        Card.new(:diamonds, :five),
        Card.new(:spades, :deuce),
        Card.new(:clubs, :deuce)
      ].shuffle
      expect(deck).to receive(:remove_cards).with(5).and_return(full_house)
      hand.hand = full_house

      expect(hand.full_house?).to eq(true)
    end
  end

  describe "#two_pair?" do
    it "should return true if hand is has two pairs" do
      two_pair = [
        Card.new(:clubs, :five),
        Card.new(:hearts, :five),
        Card.new(:diamonds, :seven),
        Card.new(:spades, :deuce),
        Card.new(:clubs, :deuce)
      ].shuffle
      expect(deck).to receive(:remove_cards).with(5).and_return(two_pair)
      hand.hand = two_pair

      expect(hand.two_pair?).to eq(true)
    end
  end

  describe "#one_pair?" do
    it "should return true if hand is has one pair" do
      one_pair = [
        Card.new(:clubs, :five),
        Card.new(:hearts, :five),
        Card.new(:diamonds, :seven),
        Card.new(:spades, :deuce),
        Card.new(:clubs, :deuce)
      ].shuffle
      expect(deck).to receive(:remove_cards).with(5).and_return(one_pair)
      hand.hand = one_pair

      expect(hand.one_pair?).to eq(true)
    end
  end

  describe "#high_card?" do
    it "should return true if hand is a high card" do
      high_card = [
        Card.new(:clubs, :five),
        Card.new(:hearts, :three),
        Card.new(:diamonds, :seven),
        Card.new(:spades, :jack),
        Card.new(:clubs, :deuce)
      ].shuffle
      expect(deck).to receive(:remove_cards).with(5).and_return(high_card)
      hand.hand = high_card
      allow(hand).to receive(:straight?).and_return(false)

      expect(hand.high_card?).to eq(true)
    end
  end

  describe "#beats?" do
    it "should return true if hand beats opponent hand" do
      high_card = [
        Card.new(:clubs, :five),
        Card.new(:hearts, :three),
        Card.new(:diamonds, :seven),
        Card.new(:spades, :jack),
        Card.new(:clubs, :deuce)
      ].shuffle

      four_of_a_kind = [
        Card.new(:clubs, :seven),
        Card.new(:hearts, :seven),
        Card.new(:diamonds, :seven),
        Card.new(:spades, :seven),
        Card.new(:clubs, :jack)
      ].shuffle

      allow(deck).to receive(:remove_cards).with(5).and_return(high_card)
      hand.hand = high_card

      opponent_hand = Hand.new(deck)
      allow(deck).to receive(:remove_cards).with(5).and_return(four_of_a_kind)
      opponent_hand.hand = four_of_a_kind



      expect(hand.beats?(opponent_hand)).to eq(false)
    end
  end

end
