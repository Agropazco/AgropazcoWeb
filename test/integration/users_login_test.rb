require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:messi)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", pasword: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
#    get root_path
#    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: {
      email:     @user.email,
      password: 'pmessi' } }
    assert logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

#    delete logout_path
#    assert_not logged_in?
#    assert_redirected_to root_url
#    follow_redirect!
#    assert_select "a[href=?]", login_path
#    assert_select "a[href=?]", logout_path,      count: 0
#    assert_select "a[href=?]", user_path(@user), count: 0
  end
end

