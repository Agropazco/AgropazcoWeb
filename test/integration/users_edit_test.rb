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
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
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

end
