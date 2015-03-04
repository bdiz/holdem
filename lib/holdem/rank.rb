
module Holdem
  class Rank
    include Comparable

    class InvalidRankError < ArgumentError; end

    RANK_VALUES = {
      'A' => 14,
      'K' => 13,
      'Q' => 12,
      'J' => 11,
      'T' => 10,
      '9' => 9,
      '8' => 8,
      '7' => 7,
      '6' => 6,
      '5' => 5,
      '4' => 4,
      '3' => 3,
      '2' => 2
    }

    attr_reader :rank
    alias_method :to_s, :rank
    alias_method :inspect, :to_s

    def initialize rank
      @rank = rank.is_a?(Fixnum) ? RANK_VALUES.invert[rank] : String(rank).upcase
      raise InvalidRankError, rank unless RANK_VALUES.has_key? @rank
    end

    def <=> other
      value <=> (other.is_a?(Rank) ? other : Rank.new(other)).value
    end

    def value
      RANK_VALUES[@rank]
    end

    # Used by group_by
    alias_method :eql?, :==
    def hash
      value.hash
    end

  end
end

