require 'minitest_helper'

describe Holdem::Card do

  let(:suits) { %w(h s d c) }
  let(:ordered_rank_values) { %w(2 3 4 5 6 7 8 9 T J Q K A) }

  it "does not allow invalid suits." do
    lambda { Holdem::Card.new("Az") }.must_raise(Holdem::Suit::InvalidSuitError) 
  end

  it "does not allow invalid ranks." do
    lambda { Holdem::Card.new("Zh") }.must_raise(Holdem::Rank::InvalidRankError) 
  end

  it "can compare against Cards, Ranks and valid card and rank constructor arguments." do
    Holdem::Card.new("7#{suits.sample}").must_be :<, Holdem::Card.new("8#{suits.sample}")
    Holdem::Card.new("7#{suits.sample}").must_be :<, Holdem::Rank.new(8)
    Holdem::Card.new("7#{suits.sample}").must_be :<, Holdem::Rank.new("k")
    Holdem::Card.new("7#{suits.sample}").must_be :<, 8
    Holdem::Card.new("7#{suits.sample}").must_be :<, "j"
    ([Holdem::Card.new("qh"), Holdem::Card.new("8c")] & [Holdem::Rank.new('q')]).must_equal [Holdem::Card.new("qd")]
    ([Holdem::Card.new("qh"), Holdem::Card.new("8c")] & [12]).must_equal [Holdem::Card.new("qd")]
  end

  it "can value cards proportionately." do
    ordered_rank_values.each_cons(2) do |a, b|
      Holdem::Card.new("#{a}#{suits.sample}").must_be :<, b
    end
  end

  it "can be sorted." do
    [Holdem::Card.new("q#{suits.sample}"), Holdem::Card.new("8#{suits.sample}")].sort.must_equal(
      [Holdem::Card.new("8#{suits.sample}"), Holdem::Card.new("q#{suits.sample}")]
    )
  end

end
