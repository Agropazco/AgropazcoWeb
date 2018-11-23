require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @post = posts(:oranges)
  end

  test "should redirect create when not logged in" do 
    assert_no_difference 'Post.count' do 
      post posts_path, params: { post: { title: "title" , content: "Lorem ipsum"}}
    end
    assert_redirected_to login_url 
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do 
      delete post_path(@post)
    end
    assert_redirected_to login_url
  end 

  test "should redirect destory for wrong posts" do 
    log_in_as(users(:admin1))
    post = posts(:papas)
    assert_no_difference 'Post.count' do 
      delete post_path(post)
    end
    assert_redirected_to root_url
  end

end
