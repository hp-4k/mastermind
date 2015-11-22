module AIPlayer
  def self.supply_secret_code
    Code.random
  end

  def self.submit_guess(board)
    # pending implementation
    board.submit_code(Code.random)
  end
end