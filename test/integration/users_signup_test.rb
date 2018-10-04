require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post signup_path, params: { user: { 
          name: " \t ",
          email: "invalid@",
          password: "123",
          password_confirmation: "321" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'

  end

  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { 
          name: "Neymar Santos",
          email: "nsantos@gmail.com",
          password: "psantos",
          password_confirmation: "psantos" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert_not flash[:danger]
    assert logged_in?
  end

end

