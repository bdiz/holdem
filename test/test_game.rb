require 'minitest_helper'

describe Holdem::Game do

  let(:game) { 
    %q(Kc 9s Ks Kd 9d 3c 6d
       9c Ah Ks Kd 9d 3c 6d
       Ac Qc Ks Kd 9d 3c
       9h 5s
       4d 2d Ks Kd 9d 3c 6d
       7s Ts Ks Kd 9d)
  }

  let(:game_result) {
    %q(Kc 9s Ks Kd 9d 3c 6d Full House (winner)
       9c Ah Ks Kd 9d 3c 6d Two Pair
       Ac Qc Ks Kd 9d 3c
       9h 5s
       4d 2d Ks Kd 9d 3c 6d Flush
       7s Ts Ks Kd 9d).gsub(/^\s*/, '')
   }

  let(:bad_game) { %q(
    Kc 9s Ks Kd 9d 3c 6d
  )}

  it "allows only valid games." do
    lambda { Holdem::Game.new(bad_game) }.must_raise(Holdem::Game::InvalidGameError)
  end

  it "can determine the winning hand." do
    Holdem::Game.new(game).winner.must_equal Holdem::Hand.new("Kc 9s Ks Kd 9d 3c 6d")
  end

  it "can pretty print the game outcome." do
    Holdem::Game.new(game).result.must_equal game_result
  end

end
