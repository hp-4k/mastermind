require "spec_helper"

RSpec.describe AIPlayer do
  context "#supply_secret_code" do
    it "generates a random secret code" do
      expect(AIPlayer.supply_secret_code).to be_a(Code)
      expect(AIPlayer.supply_secret_code).to be_valid
    end
  end
end