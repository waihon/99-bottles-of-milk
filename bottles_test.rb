# Run the test a the command line with `ruby ./bottles_test.rb`

require 'minitest/autorun'
require_relative 'bottles'

module VerseRoleTest
  def test_plays_verse_role
    assert_respond_to @role_player, :lyrics
  end
end

class CountdownSongTest < Minitest::Test
  def test_verse
    expected = "This is verse 500.\n"
    assert_equal(
      expected,
      CountdownSong.new(verse_template: VerseFake)
        .verse(500))
  end

  def test_verses
    expected =
      "This is verse 99.\n" +
      "\n" +
      "This is verse 98.\n" +
      "\n" +
      "This is verse 97.\n"
      assert_equal(
        expected,
        CountdownSong.new(verse_template: VerseFake)
          .verses(99, 97))
  end

  def test_song
    expected =
      "This is verse 47.\n" +
      "\n" +
      "This is verse 46.\n" +
      "\n" +
      "This is verse 45.\n" +
      "\n" +
      "This is verse 44.\n" +
      "\n" +
      "This is verse 43.\n"
    assert_equal(
      expected,
      CountdownSong.new(verse_template: VerseFake,
                        max: 47,
                        min: 43)
        .song
    )
  end
end

class BottleNumberTest < Minitest::Test
  def test_returns_correct_class_for_given_number
    # 0, 1, 6 are special
    assert_equal BottleNumber0, BottleNumber.for(0).class
    assert_equal BottleNumber1, BottleNumber.for(1).class
    assert_equal BottleNumber6, BottleNumber.for(6).class

    # Other numbers get the default
    assert_equal BottleNumber, BottleNumber.for(2).class
    assert_equal BottleNumber, BottleNumber.for(3).class
    assert_equal BottleNumber, BottleNumber.for(4).class
    assert_equal BottleNumber, BottleNumber.for(5).class
    assert_equal BottleNumber, BottleNumber.for(7).class
    assert_equal BottleNumber, BottleNumber.for(43).class
    assert_equal BottleNumber, BottleNumber.for(99).class
  end
end

class BottleVerseTest < Minitest::Test
  include VerseRoleTest

  def setup
    @role_player = BottleVerse
  end

  def test_verse_general_rule_upper_bound
    expected = 
      "99 bottles of milk on the wall, " +
      "99 bottles of milk.\n" +
      "Take one down and pass it around, " +
      "98 bottles of milk on the wall.\n"
    assert_equal expected, BottleVerse.lyrics(99)
  end

  def test_verse_general_rule_lower_bound
    expected =
      "3 bottles of milk on the wall, " +
      "3 bottles of milk.\n" +
      "Take one down and pass it around, " +
      "2 bottles of milk on the wall.\n"
    assert_equal expected, BottleVerse.lyrics(3)
  end

  def test_verse_7
    expected =
      "7 bottles of milk on the wall, " +
      "7 bottles of milk.\n" + 
      "Take one down and pass it around, " + 
      "1 six-pack of milk on the wall.\n"
    assert_equal expected, BottleVerse.lyrics(7)
  end

  def test_verse_6
    expected =
      "1 six-pack of milk on the wall, " +
      "1 six-pack of milk.\n" +
      "Take one down and pass it around, " +
      "5 bottles of milk on the wall.\n"
    assert_equal expected, BottleVerse.lyrics(6)
  end

  def test_verse_2
    expected =
      "2 bottles of milk on the wall, " +
      "2 bottles of milk.\n" +
      "Take one down and pass it around, " + 
      "1 bottle of milk on the wall.\n"
    assert_equal expected, BottleVerse.lyrics(2)
  end

  def test_verse_1
    expected =
      "1 bottle of milk on the wall, " +
      "1 bottle of milk.\n" +
      "Take it down and pass it around, " + 
      "no more bottles of milk on the wall.\n"
    assert_equal expected, BottleVerse.lyrics(1)
  end

  def test_verse_0
    expected =
      "No more bottles of milk on the wall, " +
      "no more bottles of milk.\n" +
      "Go to the store and buy some more, " + 
      "99 bottles of milk on the wall.\n"
    assert_equal expected, BottleVerse.lyrics(0)
  end
end

class VerseFakeTest < Minitest::Test
  include VerseRoleTest

  def setup
    @role_player = VerseFake
  end
end