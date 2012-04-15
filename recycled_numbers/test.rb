require "test/unit"
require './recycled_numbers.rb'

class TestRecycledValues < Test::Unit::TestCase
  def test_recycled_numbers
    assert_equal([54], recycled_numbers(45))
    assert_equal([], recycled_numbers(50))
    assert_equal([231,312], recycled_numbers(123))
    assert_equal([2341, 3412, 4123], recycled_numbers(1234))
  end

  def test_how_many_digits
    assert_equal(1, how_many_digits(1))
    assert_equal(2, how_many_digits(12))
    assert_equal(3, how_many_digits(123))
    assert_equal(2, how_many_digits(10))
    assert_equal(1, how_many_digits(05))
  end
end
