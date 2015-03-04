require 'minitest_helper'

describe Holdem::Suit do

  let(:suits) { %w(h s d c) }
  let(:invalid_suits) { %w(a b e z) }

  it "allows only valid suits." do
    suits.each {|s| Holdem::Suit.new(s).to_sym.must_equal s.to_sym }
  end

  it "does not allow invalid suits." do
    invalid_suits.each do |s| 
      lambda { Holdem::Suit.new(s) }.must_raise(Holdem::Suit::InvalidSuitError) 
    end
  end

  it "can detect equivelance against another suit." do
    suits.each do |suit|
      Holdem::Suit.new(suit).must_equal Holdem::Suit.new(suit)
    end
    Holdem::Suit.new('h').wont_equal Holdem::Suit.new('s')
    Holdem::Suit.new('d').wont_equal Holdem::Suit.new('c')
    Holdem::Suit.new('s').wont_equal Holdem::Suit.new('d')
    Holdem::Suit.new('c').wont_equal Holdem::Suit.new('h')
    [Holdem::Suit.new('c'), Holdem::Suit.new('c')].uniq.length.must_equal 1
  end

end

