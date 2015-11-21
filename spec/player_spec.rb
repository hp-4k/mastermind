require "spec_helper"

RSpec.describe Player do
  
  let(:human_player) { Player.new("Bob") }
  let(:ai_player) { Player.new("Skynet", :AI) }

  context "#initialize" do
    it "takes a name as the first parameter" do
      expect { Player.new("Adam") }.not_to raise_error
    end
    it "takes optional ':AI' as the second parameter to make the player AI" do
      expect { Player.new("Adam", :AI) }.not_to raise_error
    end
  end

  context "#name" do
    it "returns player's name" do
      expect(human_player.name).to eq "Bob"
    end
  end

  context "#ai?" do
    it "returns whether the player is an AI player" do
      expect(ai_player.ai?).to be true
      expect(human_player.ai?).to be false
    end
    it "if second parameter is absent it defaults to a human player" do
      expect(human_player.ai?).to be false
    end
  end

  context "#set_secret_code" do
    it "can produce a secret code" do
      expect(human_player).to respond_to(:set_secret_code)
      expect(ai_player).to respond_to(:set_secret_code)
    end
  end
end
