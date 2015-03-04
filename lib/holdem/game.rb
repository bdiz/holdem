require "holdem/hand"

module Holdem
  class Game

    class InvalidGameError < ArgumentError; end

    def initialize game
      @hands = parse_hands(game)
      raise InvalidGameError, "A game must have at least two hands." unless @hands.length >= 2
    end

    def result
      result = []
      @hands.each do |hand|
        str = hand.to_s
        descr = hand.description
        if descr
          str += " #{descr}"
        end
        if hand == winner
          str += " (winner)"
        end
        result << str
      end
      return result.join("\n")
    end

    def winner
      @hands.sort.last
    end

    private

    def parse_hands game
      String(game).split("\n").select {|h| !h.strip.empty? }.map {|h| Holdem::Hand.new(h) }
    end

  end
end
