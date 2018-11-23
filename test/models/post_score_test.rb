require 'test_helper'

class PostScoreTest < ActiveSupport::TestCase
  def setup
    @post_score = post_scores(:buyer2_score_of_apples)
  end

  test "should be valid" do
    assert @post_score.valid?
  end

  test "should require a scoring_user_id" do
    @post_score.scoring_user_id = nil
    assert_not @post_score.valid?
  end

  test "should require a post_id" do
    @post_score.post_id = nil
    assert_not @post_score.valid?
  end

  test "should require a score" do
    @post_score.score = nil
    assert_not @post_score.valid?
  end
end
