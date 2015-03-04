require 'minitest_helper'

describe Holdem::Hand do

  let(:playable_hand)      { Holdem::Hand.new("Kc 9s ks Kd 9D 3c 6d") }
  let(:hand_too_big)       { Holdem::Hand.new("Kc 9s ks Kd 9D 3c 6d 6d") }
  let(:hand_too_small)     { Holdem::Hand.new("Kc") }
  let(:hand_has_bad_cards) { Holdem::Hand.new("pc 9s ks Kd 9D 3c 6d") }

  let(:folded_hand1) { Holdem::Hand.new("Kc 9s") }
  let(:folded_hand2) { Holdem::Hand.new("Kc 9s ks Kd 9D 3c") }

  let(:royal_flush)     { Holdem::Hand.new("th jh qh kh ah 2c 3c") }
  let(:straight_flush)  { Holdem::Hand.new("4c 5c 6c 7c 8c 2h th") }
  let(:four_of_a_kind)  { Holdem::Hand.new("ks kh kc kd 3s 4c 5h") }
  let(:full_house)      { Holdem::Hand.new("th ts td as ac 2h 3c") }
  let(:flush)           { Holdem::Hand.new("ts ks 2s 6s 7s jh 3c") }
  let(:straight)        { Holdem::Hand.new("7c 8s 9d ts jh qh 3c") }
  let(:three_of_a_kind) { Holdem::Hand.new("5s 5h 5c jd ad 2h 3c") }
  let(:two_pair)        { Holdem::Hand.new("as ah 3c 3s jc 5d 7h") }
  let(:one_pair)        { Holdem::Hand.new("qd qh 2h 8s 9c 4c 6s") }
  let(:nothing)         { Holdem::Hand.new("qd kh 2h 8s 9c 4c 6s") }
  let(:folded)          { Holdem::Hand.new("qd qh 2h 8s") }

  let(:poker_hand_strings_in_order) { Holdem::Hand::POKER_HANDS_IN_ORDER }
  let(:poker_hands_in_order)        { Holdem::Hand::POKER_HANDS_IN_ORDER.map {|str| eval(str) } }

  it "allows only valid hands." do
    lambda { hand_too_big }.must_raise(Holdem::Hand::InvalidHandError)
    lambda { hand_too_small }.must_raise(Holdem::Hand::InvalidHandError)
    lambda { hand_has_bad_cards }.must_raise(Holdem::Rank::InvalidRankError)
  end

  it "can tell if a hand was folded." do
    folded_hand1.folded?.must_equal true
    folded_hand2.folded?.must_equal true
  end

  it "can tell if a hand is played." do
    playable_hand.played?.must_equal true
  end

  it "can identify a poker hand." do
    poker_hand_strings_in_order.each do |hand|
      eval "#{hand}.#{hand}?.must_equal true"
    end
    poker_hand_strings_in_order.each do |hand|
      (poker_hand_strings_in_order - [hand]).each do |other_ranking|
        next if hand == "royal_flush" and other_ranking == "straight_flush"
        next if hand == "royal_flush" and other_ranking == "flush"
        next if hand == "royal_flush" and other_ranking == "straight"
        next if hand == "straight_flush" and other_ranking == "flush"
        next if hand == "straight_flush" and other_ranking == "straight"
        next if hand == "full_house" and other_ranking == "three_of_a_kind"
        next if hand == "full_house" and other_ranking == "one_pair"
        next if hand == "two_pair" and other_ranking == "one_pair"
        next if hand == "folded" and other_ranking == "nothing"
        # puts eval("#{hand}.to_s")
        # puts "#{hand}.#{other_ranking}?.must_equal false"
        eval "#{hand}.#{other_ranking}?.must_equal false"
      end
    end
  end

  it "can value hands proportionately." do
    poker_hands_in_order.each_cons(2) {|a, b| a.must_be :<, b }
  end

  it "can be sorted." do
    poker_hands_in_order.shuffle.sort.must_equal poker_hands_in_order
  end

  it "can provide hand descriptions" do
    royal_flush.description.must_equal "Royal Flush"
    flush.description.must_equal "Flush"
    nothing.description.must_be_nil
    folded.description.must_be_nil
  end

end

