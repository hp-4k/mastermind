require "spec_helper"

RSpec.describe Code do
  context "#initialize" do
    it "has to be initialized with 4 elements" do
      expect { Code.new(1, 2, 3, 4) }.not_to raise_error
      expect { Code.new(1, 2, 3) }.to raise_error ArgumentError
      expect { Code.new(1, 2, 3, 4, 5) }.to raise_error ArgumentError
      expect { Code.new }.to raise_error ArgumentError
    end
  end

  context "valid?" do
    it "returns true if all elements are digits between 1 and 6" do
      expect(Code.new(1, 2, 3, 4)).to be_valid
      expect(Code.new(1, 1, 1, 1)).to be_valid
      expect(Code.new(4, 4, 4, 4)).to be_valid
    end
    it "returns false for invalid codes" do
      expect(Code.new(1, 2, 3, 7)).to_not be_valid
      expect(Code.new(0, 0, 0, 0)).to_not be_valid
      expect(Code.new(1, 2, 3, 'a')).to_not be_valid
      expect(Code.new(1, 2, 3, :a)).to_not be_valid
      expect(Code.new(-1, -2, -3, -4)).to_not be_valid
      expect(Code.new("1", "2", "3", "4")).to_not be_valid
    end
  end

  context "self.random" do
    it "should generate a new valid code" do
      expect(Code.random).to be_valid
    end
  end
end