require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:messi)
    @buyer_user = @user
    @vendor_user = users(:valdez)
    @admin_user = users(:master)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                             email: "foo@invalid",
                                             password: "foo",
                                             password_confirmation: "bar" } }
    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    patch user_path(@user), params: { user: { name:  name,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    patch user_path(@user), params: { user: { name:  name,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
  end

  test "Shows user type correctly" do
    cases = [ [@vendor_user, "Vendedor"],
              [@admin_user, "Administrador"],
              [@buyer_user, "Comprador"] ]
    for u, u_type in cases do
      log_in_as(u)
      get edit_user_path(u)
      response.include?(u_type)
    end
  end

  test "no change the email" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    email = @user.email
    patch user_path(@user), params: { user: { name: @user.name,
                                             email: "newfoo@mail.com",
                                             password: "foo12345",
                                             password_confirmation: "foo12345" } }
    assert_redirected_to @user
    @user.reload
    assert_equal @user.email, email
  end

end
