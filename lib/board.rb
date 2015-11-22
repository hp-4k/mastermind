class Board
  
  attr_reader :secret_code, :total_attempts, :submitted_codes, :lines_of_feedback

  def initialize(total_attempts)
    @total_attempts = total_attempts
    @submitted_codes = []
    @lines_of_feedback = []
  end

  def set_secret_code(secret_code)
    @secret_code = secret_code
  end

  def submit_code(code)
    @submitted_codes << code
    @lines_of_feedback << code.generate_feedback(secret_code)
  end

  def attempts_left
    total_attempts - submitted_codes.size
  end

  def attempts_left?
    submitted_codes.size < total_attempts
  end

  def code_guessed?
    submitted_codes.empty? ? false : submitted_codes.last.matches?(secret_code)
  end

  def clear
    @secret_code = nil
    @submitted_codes = []
    @lines_of_feedback = []
  end

  def print_board
    puts '-' * 9
    puts '? ? ? ? |'
    puts '-' * 43
    submitted_codes.each_with_index { |code, index| print_board_line(code, lines_of_feedback[index]) }
  end

  private

    def print_board_line(code, feedback)
      puts "#{code} | #{print_feedback(feedback)}"
    end

    def print_feedback(feedback)
      "black pins: #{feedback[:black]}, white pins: #{feedback[:white]}"
    end
end