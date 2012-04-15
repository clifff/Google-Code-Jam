require "test/unit"
require './dancing_with_googlers.rb'

class TestDancingWithGooglers < Test::Unit::TestCase
  def test_valid_scores?
    assert_equal(true, valid_scores?([8,8,8], 24))
    assert_equal(true, valid_scores?([7,8,7], 22))
    assert_equal(true, valid_scores?([6,7,8], 21))
    assert_equal(true, valid_scores?([6,8,8], 22))
    assert_equal(true, valid_scores?([0,0,0], 0))
    assert_equal(false, valid_scores?([7,6,9], 22))
    assert_equal(false, valid_scores?([1,0,0], 0))
    assert_equal(false, valid_scores?([11,1,1], 14))
    assert_equal(false, valid_scores?([-1,1,1], 1))
  end

  def test_score_analysis
    assert_equal([true, false], analysis_of_score(29, 8) )
    assert_equal([true, true], analysis_of_score(20, 8) )
    assert_equal([false, false], analysis_of_score(8, 8) )
    assert_equal([false, false], analysis_of_score(18, 8) )
    assert_equal([true, true], analysis_of_score(21, 8) )
  end
end
