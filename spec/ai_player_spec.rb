require "spec_helper"

RSpec.describe AIPlayer do
  context "#set_secret_code" do
    it "generates a random secret code" do
      expect(AIPlayer.set_secret_code).to be_a(Code)
      expect(AIPlayer.set_secret_code).to be_valid
    end
  end
end