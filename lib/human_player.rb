module HumanPlayer
  def self.supply_secret_code
    prompt("secret")
  end

  def self.submit_guess(board)
    board.submit_code(prompt("guess"))
  end

  private

    def self.prompt(input_type)
      input_code = temporary_code
      until input_code.valid?
        begin
          puts "Enter the new #{input_type} seperated by spaces:"
          input_code = Code.new(*convert_input_to_code(gets.chomp))
        rescue
          input_code = temporary_code
        end
        puts "Invalid code, try again" unless input_code.valid?
      end
      input_code
    end

    def self.temporary_code
      Code.new(-1, -1, -1, -1)
    end

    def self.convert_input_to_code(input)
      input.split.map {|e| e.to_i}
    end
end