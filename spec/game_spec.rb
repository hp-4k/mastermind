require "spec_helper"

RSpec.describe Game do
  context "#initialize" do
    it "takes a hash as the only parameter" do
      expect { Game.new({players: [], board: "b"}) }.not_to raise_error
      expect { Game.new }.to raise_error ArgumentError
      expect { Game.new(1, 2) }.to raise_error ArgumentError
    end
    it "requires players: key with an array of players in the initialization hash" do
      expect { Game.new({board: "b"}) }.to raise_error ArgumentError
    end
    it "requires board: key in the initialization hash" do
      expect { Game.new({players: "b"}) }.to raise_error ArgumentError
    end
    it "sets the first player as a codemaker by default" do
      game = Game.new({players: ["player1", "player2"],
                       board: "b"})
      expect(game.codemaker).to eq "player1"
    end
    it "sets the second player as a codebreaker by default" do
      game = Game.new({players: ["player1", "player2"],
                       board: "b"})
      expect(game.codebreaker).to eq "player2"
    end
  end

  context "#winner" do
    it "returns the codebreaker if codebreaker broke the code" do
      board = double("Board", code_guessed?: true, attempts_left?: true)
      game = Game.new(players: ["p1", "p2"], board: board)
      expect(game.winner).to eq game.codebreaker
    end
    it "returns the codebreaker if all attempts used but codebreaker broke the code" do
      board = double("Board", code_guessed?: true, attempts_left?: false)
      game = Game.new(players: ["p1", "p2"], board: board)
      expect(game.winner).to eq game.codebreaker
    end
    it "returns the codemaker if all attempts used and code not guessed" do
      board = double("Board", code_guessed?: false, attempts_left?: false)
      game = Game.new(players: ["p1", "p2"], board: board)
      expect(game.winner).to eq game.codemaker
    end
    it "returns nil otherwise" do
      board = double("Board", code_guessed?: false, attempts_left?: true)
      game = Game.new(players: ["p1", "p2"], board: board)
      expect(game.winner).to be_nil
    end
  end

  context "#play" do
    it "implements #play method" do
      expect(Game.new({players: [], board: "b"})).to respond_to :play
    end
  end
end