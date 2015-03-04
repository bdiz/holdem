require 'minitest_helper'

describe Holdem do

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

  let(:binary) { File.expand_path("../../bin/holdem", __FILE__) }

  it "can pretty print the game outcome." do
    # system("#{binary} \"#{game}\"")
    # .must_equal game_result
  end

end
