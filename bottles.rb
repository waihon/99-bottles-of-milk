class CountdownSong
  attr_reader :verse_template, :max, :min

  def initialize(verse_template: BottleVerse, max: 99, min: 0)
    @verse_template = verse_template
    @max, @min = max, min
  end

  def song
    verses(99, 0)
  end

  def verses(upper, lower)
    upper.downto(lower).map { |i| verse(i) }.join("\n") 
  end

  def verse(number)
    verse_template.lyrics(number)
  end
end

class BottleNumber
  def self.for(number)
    registry.find do |candidate|
      candidate.handles?(number)
    end.new(number)
  end

  def self.registry
    # The superclass itself won't get automatically registered
    # via the inherited hook so we'll need to ensure that it will.
    @registry ||= [BottleNumber]
  end

  def self.register(candidate)
    registry.prepend(candidate)
  end

  def self.inherited(candidate)
    register(candidate)
  end

  def self.handles?(number)
    true
  end

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def to_s
    "#{quantity} #{container}"
  end

  def quantity
    number.to_s
  end

  def container
    "bottles"
  end

  def action
    "Take #{pronoun} down and pass it around"
  end

  def pronoun
    "one"
  end

  def successor
    BottleNumber.for(number - 1)
  end
end

class BottleNumber0 < BottleNumber
  def self.handles?(number)
    number == 0 
  end

  def quantity
    "no more"
  end

  def action
    "Go to the store and buy some more"
  end

  def successor
    BottleNumber.for(99)
  end
end

class BottleNumber1 < BottleNumber
  def self.handles?(number)
    number == 1 
  end

  def container
    "bottle"
  end

  def pronoun
    "it"
  end
end

class BottleNumber6 < BottleNumber
  def self.handles?(number)
    number == 6 
  end
  
  def quantity
    "1"
  end

  def container
    "six-pack"
  end
end

class BottleVerse
  def self.for(number)
    new(BottleNumber.for(number))
  end

  def self.lyrics(number)
    self.for(number).lyrics
  end

  attr_reader :bottle_number

  def initialize(bottle_number)
    @bottle_number = bottle_number
  end

  def lyrics
    "#{bottle_number} of milk on the wall, ".capitalize +
    "#{bottle_number} of milk.\n" +
    "#{bottle_number.action}, " +
    "#{bottle_number.successor} of milk on the wall.\n"
  end
end

class VerseFake
  def self.lyrics(number)
    "This is verse #{number}.\n"
  end
end