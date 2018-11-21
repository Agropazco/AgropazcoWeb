require 'test_helper'

class PostInterfaceTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:valdez)
  end
  test "micropost interface" do 
    
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    #Invalid submission
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { title: "", content: "" }}
    end
    assert_select 'div#error_explanation'
    #Valid submission
    title= "title" 
    content = "example content"
    assert_difference 'Post.count' , 1 do 
      post posts_path , params: { post: {title: title , content: content}}
    end 
    assert_redirected_to root_url 
    follow_redirect!
    assert_match content, response.body 
    #Delete post 
    assert_select 'a' , text: 'delete'
    first_post = @user.posts.paginate(page:1).first 
    assert_difference 'Post.count' , -1 do 
      delete post_path(first_post)
    end 
    #Visit different user ( no delete links) 
    get user_path(users(:messi))
    assert_select 'a' , text: 'delete' , count: 0 
  end 
  test "micropost sidebar count" do 
    log_in_as(@user)
    get root_path 
    num_posts = @user.posts.count
    assert_match "#{num_posts} posts", response.body
    #User with zero posts 
    other_user = users(:ronaldo)
    log_in_as(other_user)
    get root_path 
    assert_match "0 posts", response.body
    other_user.posts.create!(title:"title", content:"content")
    get root_path
    assert_match other_user.name , response.body 
  end

end
