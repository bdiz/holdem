require "holdem/version"
require "holdem/game"

module Holdem

  def self.play!
    game = Holdem::Game.new(ARGV[0])
    puts game.result
  rescue ArgumentError => e
    puts e.message
    exit 1
  end

end
