require "test/unit"
require './diamond_inheritance.rb'

class TestDiamond < Test::Unit::TestCase
  def test_diamond_inheritance?
    assert_equal true, diamond_inheritance?(1, [[2,3],[3],[]])
    assert_equal false, diamond_inheritance?(1, [[2],[3],[]])
    assert_equal true, diamond_inheritance?(1, [[2,3],[4],[4], []])
    assert_equal false, diamond_inheritance?(1, [[2],[3],[4],[]])
    assert_equal true, diamond_inheritance?(1, [[2, 5],[3],[4],[5], []])
    assert_equal true, diamond_inheritance?(1, [[2, 3],[3], []])
    assert_equal true, diamond_inheritance?(27, [[], [], [], [12, 40], [], [], [], [17], [], [], [], [], [], [], [], [], [], [], [], [22], [], [], [11], [], [], [33], [8, 17], [], [], [29], [], [], [], [3], [], [13], [6, 35], [], [], [32], [], [], [42], [], []])
  end
end
