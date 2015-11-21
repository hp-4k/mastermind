require "ai_player"
require "human_player"
require "forwardable"

class Player
  extend Forwardable
  def_delegators :@input, :set_secret_code

  attr_reader :name

  def initialize(name, ai = false)
    @name = name
    @ai = ai == :AI
    load_player_behaviour
  end

  def ai?
    @ai
  end

  private

  def load_player_behaviour
    @input = @ai ? AIPlayer : HumanPlayer
  end
end