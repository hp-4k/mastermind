class Code
  
  NUMBER_OF_PIN_TYPES = 6

  attr_reader :pins

  def self.random
    Code.new(*Array.new(4) { Random.rand(NUMBER_OF_PIN_TYPES) + 1 })
  end

  def initialize(*pins)
    @pins = pins
    raise ArgumentError if @pins.length != 4
  end

  def valid?
    pins.all? { |pin| pin.is_a?(Integer) && pin.between?(1, NUMBER_OF_PIN_TYPES) }
  end

  def matches?(other)
    pins == other.pins
  end

  def generate_feedback(other)
    feedback = {}
    feedback[:black] = count_black_pins(other.pins)
    feedback[:white] = count_white_pins(other.pins)
    feedback
  end

  private

    def count_black_pins(other_pins)
      black_pins = 0
      pins.each_with_index do |pin, index|
        black_pins += 1 if pin == other_pins[index]
      end
      black_pins
    end

    def count_white_pins(other_pins)
      white_pin_candidates = 0
      pins.uniq.each do |pin|
        white_pin_candidates += [pins.count(pin), other_pins.count(pin)].min if other_pins.include?(pin)
      end
      white_pin_candidates - count_black_pins(other_pins)
    end
end