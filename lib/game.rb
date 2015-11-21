class Game
  attr_reader :codemaker, :codebreaker, :board

  def initialize(args)
    @codemaker, @codebreaker = args.fetch(:players) {
      raise ArgumentError, "Game.new requires :player key" }
    @board = args.fetch(:board) {
      raise ArgumentError, "Game.new requires :board key" }
  end

  def play
    
  end
end