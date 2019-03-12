require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup 
    @user = users(:vendor1)
    @post = posts(:apples)
  end

  test "profile display" do
    log_in_as @user
    get user_path(@user)
    assert @post 
    assert_template 'users/show'
    assert_select 'title',full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.posts.count.to_s, response.body
    assert_select 'div.pagination', count:1
    @user.posts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body 
    end
  end 
end
