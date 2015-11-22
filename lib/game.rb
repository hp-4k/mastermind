class Game
  attr_reader :codemaker, :codebreaker, :board

  def initialize(args)
    @codemaker, @codebreaker = args.fetch(:players) {
      raise ArgumentError, "Game.new requires :player key" }
    @board = args.fetch(:board) {
      raise ArgumentError, "Game.new requires :board key" }
  end

  def play
    begin_game
    while true
      reset_game
      board.set_secret_code(codemaker.supply_secret_code)
      until winner
        guess_by_codebreaker
      end
      break unless play_again?
      swap_players
    end
    finish_game
  end

  def winner
    return codebreaker if board.code_guessed?
    return codemaker unless board.attempts_left?
  end

  private

    def begin_game
      puts "INTRODUCTION WILL BE PRINTED HERE"
    end

    def reset_game
      board.clear
    end

    def guess_by_codebreaker
      print_board
      print_attempts_left
      codebreaker.submit_guess(board)
    end

    def print_board
      board.print
    end

    def print_attempts_left
      puts "The codebraker has #{board.attempts_left} attempts left"
    end

    def end_game
      puts "Thanks for playing!"
    end

    def play_again?
      puts "/nDo you want to swap sides and play again? (Y)"
      gets.chomp.upcase == 'Y'
    end

    def swap_players
      @codemaker, @codebreaker = @codebreaker, @codemaker
    end
end