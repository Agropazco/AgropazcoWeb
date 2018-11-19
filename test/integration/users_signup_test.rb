require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post signup_path, params: { user: { 
        name: " \t ",
        email: "invalid@",
        password: "123",
        password_confirmation: "321",
        role: :buyer } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'

  end

  test "valid signup information" do

    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password",
                                         role: :vendor } }
    end


    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?

    # Try to log in before activation.
    log_in_as(user)
    assert_not logged_in?

    # Invalid activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not logged_in?

    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not logged_in?

    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert logged_in?
  end

  test "should not create admin" do
    get signup_path
    assert_no_difference "User.count" do
      post signup_path, params: { user: { 
        name: "pepito hacker",
        email: "hackeradmin@mail.com",
        password: "Contra1234",
        password_confirmation: "Contra1234",
        role: :admin } }
    end
  end

end

