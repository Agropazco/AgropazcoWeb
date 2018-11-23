require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = comments(:comment1)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "body should be at most 1000 characters long" do
    @comment.body = "a" * 1000
    assert @comment.valid?
    @comment.body += "a"
    assert_not @comment.valid?
  end

end
