class Code
  
  MAX_PINS = 6

  def self.random
    Code.new(*Array.new(4) { Random.rand(MAX_PINS) + 1 })
  end

  def initialize(*pins)
    @pins = pins
    raise ArgumentError if @pins.length != 4
  end

  def valid?
    @pins.all? { |pin| pin.is_a?(Integer) && pin.between?(1,MAX_PINS) }
  end
end