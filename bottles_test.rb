# Run the test a the command line with `ruby ./bottles_test.rb`

require 'minitest/autorun'
require_relative 'bottles'

class BottlesTest < Minitest::Test
  def test_the_first_verse
    expected = 
      "99 bottles of milk on the wall, " +
      "99 bottles of milk.\n" +
      "Take one down and pass it around, " + 
      "98 bottles of milk on the wall.\n"
    assert_equal expected, Bottles.new.verse(99)
  end
end