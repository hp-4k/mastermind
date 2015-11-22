require "spec_helper"

RSpec.describe Board do

  let(:board) { Board.new(12) }
  
  def sample_code(id = 0)
    double(id, generate_feedback: {black: 0, white: 4}, to_s: "code #{id}")
  end

  context "#initialize" do
    it "is initialized with the number of attempts" do
      expect { Board.new(12) }.not_to raise_error
      expect { Board.new }.to raise_error ArgumentError
    end
  end

  context "#total_attempts" do
    it "returns the number of total attempts on board" do
      expect(board.total_attempts).to eq 12
    end
  end

  context "#submit_code" do
    it "puts a new code guess on board" do
      board.submit_code(sample_code(1))
      board.submit_code(sample_code(2))
      board.submit_code(sample_code(3))
      expect(board.submitted_codes.length).to eq 3
    end
  end

  context "#submitted_codes" do
    it "returns an array of submitted codes" do
      a, b, c = sample_code(1), sample_code(2), sample_code(3)
      board.submit_code(a)
      board.submit_code(b)
      board.submit_code(c)
      expect(board.submitted_codes).to eq [a, b, c]
    end
  end

  context "#set_secret_code" do
    it "sets a new secret code" do
      board.set_secret_code("new code")
      expect(board.secret_code).to eq "new code"
    end
  end

  context "#attempts_left" do
    it "returns the number of attempts left" do
      3.times { board.submit_code(sample_code) }
      expect(board.attempts_left).to eq 9
    end
  end

  context "#attempts_left?" do
    it "returns true if attempts left on board" do
      11.times { board.submit_code(sample_code) }
      expect(board.attempts_left?).to be true
    end
    it "returns false if no attempts left on board" do
      12.times { board.submit_code(sample_code) }
      expect(board.attempts_left?).to be false
    end
  end

  context "#code_guessed?" do
    it "returns true if last guessed code matches the secret" do
      matching_code = double("Code", generate_feedback: nil, matches?: true)
      4.times { board.submit_code(sample_code("wrong guess"))}
      board.submit_code(matching_code)
      expect(board.code_guessed?).to be true
    end
    it "returns false if last guessed code does not match the secret" do
      not_matching_code = double("Code", generate_feedback: nil, matches?: false)
      2.times { board.submit_code(sample_code("wrong guess"))}
      board.submit_code(not_matching_code)
      expect(board.code_guessed?).to be false
    end
  end

  context "#clear" do
    it "deletes all submitted codes" do
      4.times { board.submit_code(sample_code)}
      board.clear
      expect(board.submitted_codes.length).to eq 0
    end
    it "deletes all lines of feedback" do
      4.times { board.submit_code(sample_code)}
      board.clear
      expect(board.lines_of_feedback.length).to eq 0
    end
    it "deletes the secret code" do
      board.set_secret_code(sample_code("secret"))
      board.clear
      expect(board.secret_code).to be_nil
    end
  end

  context "#print_board" do
    it "print a board with one line to the screen" do
      board.submit_code(sample_code(0))
      expect(STDOUT).to receive(:puts).with("code 0 | black pins: 0, white pins: 4")
      board.print_board
    end
    it "print a board with multiple lines to the screen" do
      board.submit_code(sample_code(0))
      board.submit_code(sample_code(1))
      board.submit_code(sample_code(2))
      expect(STDOUT).to receive(:puts).with("code 0 | black pins: 0, white pins: 4")
      expect(STDOUT).to receive(:puts).with("code 1 | black pins: 0, white pins: 4")
      expect(STDOUT).to receive(:puts).with("code 2 | black pins: 0, white pins: 4")
      board.print_board
    end
  end
end