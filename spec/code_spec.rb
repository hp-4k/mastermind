require "spec_helper"

RSpec.describe Code do
  context "self.random" do
    it "should generate a new valid code" do
      expect(Code.random).to be_valid
    end
  end

  context "#initialize" do
    it "has to be initialized with 4 elements" do
      expect { Code.new(1, 2, 3, 4) }.not_to raise_error
      expect { Code.new(1, 2, 3) }.to raise_error ArgumentError
      expect { Code.new(1, 2, 3, 4, 5) }.to raise_error ArgumentError
      expect { Code.new }.to raise_error ArgumentError
    end
  end

  context "#valid?" do
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

  context "matches?(other_code)" do
    let(:code) { Code.new(1, 2, 3, 4)}
    it "returns true if both codes are identical" do
      expect(code.matches?(Code.new(1, 2, 3, 4))).to be true
    end
    it "returns false if codes are different" do
      expect(code.matches?(Code.new(2, 3, 4, 5))).to be false
      expect(code.matches?(Code.new(2, 1, 3, 4))).to be false
      expect(code.matches?(Code.new(6, 6, 6, 6))).to be false
    end
  end

  context "#generate_feedback(other)" do
    it "returns correct feedback for a guess with white and black pins" do
      feedback = Code.new(1, 2, 3, 4).generate_feedback(Code.new(4, 5, 3, 6))
      expect(feedback[:black]).to eq 1
      expect(feedback[:white]).to eq 1
    end
    it "returns correct feedback for a guess with black pins only" do
      feedback = Code.new(1, 2, 3, 4).generate_feedback(Code.new(5, 2, 3, 6))
      expect(feedback[:black]).to eq 2
      expect(feedback[:white]).to eq 0
    end
    it "returns correct feedback for a guess with white pins only" do
      feedback = Code.new(1, 2, 3, 4).generate_feedback(Code.new(6, 4, 1, 2))
      expect(feedback[:black]).to eq 0
      expect(feedback[:white]).to eq 3
    end
    it "returns correct feedback for a guess without any pins" do
      feedback = Code.new(1, 2, 3, 4).generate_feedback(Code.new(6, 6, 5, 5))
      expect(feedback[:black]).to eq 0
      expect(feedback[:white]).to eq 0
    end
    it "returns correct feedback with repeating pins in secret" do
      feedback = Code.new(1, 2, 2, 1).generate_feedback(Code.new(4, 1, 2, 2))
      expect(feedback[:black]).to eq 1
      expect(feedback[:white]).to eq 2
    end
    it "returns correct feedback with repeating pins in guess" do
      feedback = Code.new(1, 2, 3, 4).generate_feedback(Code.new(1, 1, 1, 1))
      expect(feedback[:black]).to eq 1
      expect(feedback[:white]).to eq 0
    end
    it "returns correct feedback with repeating pins in secret and guess" do
      feedback = Code.new(2, 2, 6, 6).generate_feedback(Code.new(2, 6, 2, 6))
      expect(feedback[:black]).to eq 2
      expect(feedback[:white]).to eq 2
    end
    it "is commutative" do
      expect(Code.new(2, 2, 6, 6).generate_feedback(Code.new(2, 6, 2, 6))).to eq Code.new(2, 6, 2, 6).generate_feedback(Code.new(2, 2, 6, 6))
    end
  end

  context "#to_s" do
    it "returns a textual representation of the code" do
      expect(Code.new(1, 2, 3, 4).to_s).to eq "1 2 3 4"
      expect(Code.new(6, 6, 6, 6).to_s).to eq "6 6 6 6"
    end
  end
end