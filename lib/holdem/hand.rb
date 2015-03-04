require "holdem/card"

module Holdem
  class Hand
    include Comparable

    class InvalidHandError < ArgumentError; end

    CARDS_IN_A_FOLDED_HAND = (2..6)
    CARDS_IN_A_PLAYABLE_HAND = 7

    POKER_HANDS_IN_ORDER = %w(
      folded
      nothing
      one_pair
      two_pair
      three_of_a_kind
      straight
      flush
      full_house
      four_of_a_kind
      straight_flush
      royal_flush
    )

    def initialize hand
      @cards = String(hand).split().map {|card| Holdem::Card.new(card) }
      raise InvalidHandError, @cards.join(' ') unless folded? or played?
    end

    def played?
      CARDS_IN_A_PLAYABLE_HAND == @cards.length
    end

    def royal_flush?
      played? and straight? and (highest_straight.last == Holdem::Rank.new('A')) and highest_straight.map(&:suit).uniq.length == 1
    end

    def straight_flush?
      played? and straights.any? {|straight| straight.map(&:suit).uniq.length == 1 }
    end

    def four_of_a_kind?
      played? and (rank_groups_with_size(4).length == 1)
    end

    def full_house?
      played? and ((three_of_a_kind? and one_pair?) or (rank_groups_with_size(3).length == 2))
    end

    def flush?
      played? and @cards.group_by(&:suit).values.any? {|group| group.length >= 5 }
    end

    def straight?
      played? and !highest_straight.nil?
    end

    def three_of_a_kind?
      played? and (rank_groups_with_size(3).length >= 1)
    end

    def two_pair?
      played? and (rank_groups_with_size(2).length >= 2)
    end

    def one_pair?
      played? and (rank_groups_with_size(2).length >= 1)
    end

    def nothing?
     played? and !(
        royal_flush? or
        straight_flush? or
        four_of_a_kind? or
        full_house? or
        flush? or
        straight? or
        three_of_a_kind? or
        two_pair? or
        one_pair?
      )
    end

    def folded?
      CARDS_IN_A_FOLDED_HAND.include? @cards.length
    end

    def description
      POKER_HANDS_IN_ORDER.reverse.each do |poker_hand|
        next if poker_hand == "nothing" or poker_hand == "folded"
        return underscore_to_phrase(poker_hand) if eval("#{poker_hand}?")
      end
      return nil
    end

    def underscore_to_phrase str
      str = str.dup
      str[0] = str[0].upcase
      while idx = str.index(/_./)
        str[idx] = ' '
        str[idx+1] = str[idx+1].upcase
      end
      return str
    end

    def <=> other
      POKER_HANDS_IN_ORDER.reverse.each do |poker_hand|
        result = eval("#{poker_hand}?")
        other_result = eval("other.#{poker_hand}?")
        if result and other_result
          return 0
        elsif result
          return 1
        elsif other_result
          return -1
        end
      end
      return 0
    end

    def to_s
      @cards.join(' ')
    end

    private

    # size=2: [[As, Ah], [3c, 3s]]
    def rank_groups_with_size size
      cards_grouped_by_rank.group_by(&:length)[size] || []
    end

    # [[Th, Ts, Td], [As, Ac], [2h], [3c]]
    def cards_grouped_by_rank
      @cards.group_by(&:rank).values
    end

    ########

    def highest_straight
      straights.last
    end

    # [[7c, 8s, 9d, Ts, Jh], [8s, 9d, Ts, Jh, Qh]]
    def straights
      straights = []
      (2..10).each do |value|
        possible_straight = (@cards & (value..(value+4)).to_a)
        straights << possible_straight.sort if possible_straight.length == 5
      end
      return straights
    end

  end
end
