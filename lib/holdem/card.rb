require 'holdem/rank'
require 'holdem/suit'

module Holdem
  class Card
    include Comparable

    RANK_CHARACTER_POSITION = 0
    SUIT_CHARACTER_POSITION = 1

    attr_reader :rank, :suit

    def initialize str
      @rank = Holdem::Rank.new(str[RANK_CHARACTER_POSITION])
      @suit = Holdem::Suit.new(str[SUIT_CHARACTER_POSITION])
    end

    def <=> other
      @rank <=> case other
        when Card
          other.rank
        when Rank
          other
        else
          begin
            Card.new(other).rank
          rescue ArgumentError
            Rank.new(other)
          end
        end
    end

    def to_s
      "#{rank}#{suit}"
    end

    alias_method :inspect, :to_s

    alias_method :eql?, :==
    def hash
      rank.hash
    end

  end
end
