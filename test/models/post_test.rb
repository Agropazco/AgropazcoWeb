require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:buyer1)
    @post = @user.posts.build(title: "title" , content:"Lorem ipsum")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "title should be present" do
    @post.title = nil
    assert_not @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "title should be at most 100 characters long" do
    @post.title = "a" * 100
    assert @post.valid?
    @post.title += "a"
    assert_not @post.valid?
  end

  test "content should be at most 10000 characters long" do
    @post.content = "a" * 10000
    assert @post.valid?
    @post.content += "a"
    assert_not @post.valid?
  end

  test "order should be most recent first" do 
    assert_equal posts( :most_recent) , Post.first
  end 

end
