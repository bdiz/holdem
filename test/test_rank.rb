require 'minitest_helper'

describe Holdem::Rank do

  let(:invalid_ranks) { %w(1 z x r 23) }
  let(:ordered_rank_values) { %w(2 3 4 5 6 7 8 9 T J Q K A) }

  it "can take different types of constructor arguments" do
    Holdem::Rank.new('Q').rank.must_equal "Q"
    Holdem::Rank.new('q').rank.must_equal "Q"
    Holdem::Rank.new(12).rank.must_equal "Q"
    Holdem::Rank.new(Holdem::Rank.new('q')).rank.must_equal "Q"
  end

  it "can assess equality against another rank" do 
    Holdem::Rank.new('q').must_equal Holdem::Rank.new('q')
  end

  it "can value ranks proportionately." do
    ordered_rank_values.each_cons(2) do |a, b|
      Holdem::Rank.new(a).must_be :<, Holdem::Rank.new(b)
    end
  end

  it "does not allow invalid ranks." do
    invalid_ranks.each do |r| 
      lambda { Holdem::Rank.new(r) }.must_raise(Holdem::Rank::InvalidRankError) 
    end
  end

end

