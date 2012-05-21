require "test/unit"
require './out_of_gas.rb'

class TestGas < Test::Unit::TestCase
  def test_position_at_time
    o = Other.new
    o.add_input([0.000000, 0.000000])
    o.add_input([10000.000000, 0.100000])
    o.add_input([10000.100000, 100000.000000])
    assert_equal 0, o.index_at_time(5000.0)
    assert_equal 0.05, o.position_at_time(5000.0)
    assert_equal 1, o.index_at_time(10000.0)
    assert_equal 0.1, o.position_at_time(10000.0)
    assert_equal 100000.000000, o.position_at_time(10000.1)
  end
end
