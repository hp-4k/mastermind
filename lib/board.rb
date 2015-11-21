class Board
  
  attr_reader :secret_code, :total_attempts, :submitted_codes

  def initialize(total_attempts)
    @total_attempts = total_attempts
    @submitted_codes = []
  end

  def set_secret_code(secret_code)
    @secret_code = secret_code
  end

  def submit_code(code)
    @submitted_codes << code
  end

  def attempts_left?
    submitted_codes.size < total_attempts
  end

  def code_guessed?
    submitted_codes.last.matches?(secret_code)
  end

  def clear
    @secret_code = nil
    @submitted_codes = []
  end
end