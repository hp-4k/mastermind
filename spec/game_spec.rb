require "spec_helper"

RSpec.describe Game do
  context "#initialize" do
    it "takes a hash as the only parameter" do
      expect { Game.new({players: [], board: "b"}) }.not_to raise_error
      expect { Game.new }.to raise_error ArgumentError
      expect { Game.new(1, 2) }.to raise_error ArgumentError
    end
    it "requires players: key in the initialization hash" do
      expect { Game.new({board: "b"}) }.to raise_error ArgumentError
    end
    it "requires board: key in the initialization hash" do
      expect { Game.new({players: "b"}) }.to raise_error ArgumentError
    end
  end

  context "#play" do
    it "implements #play method" do
      expect(Game.new({players: [], board: "b"})).to respond_to :play
    end
  end
end