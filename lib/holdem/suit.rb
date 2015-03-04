
module Holdem
  class Suit

    class InvalidSuitError < ArgumentError; end

    VALID_SUITS = [:s, :c, :d, :h]

    def initialize suit
      @symbol = String(suit).downcase.to_sym
      raise InvalidSuitError, suit unless VALID_SUITS.include? @symbol
    end

    def == other
      to_sym == (other.is_a?(Suit) ? other : Suit.new(other)).to_sym
    end

    alias_method :eql?, :==

    def to_sym
      return @symbol
    end

    def hash
      @symbol.hash
    end

    def to_s
      @symbol.to_s
    end

    alias_method :inspect, :to_s

  end
end

