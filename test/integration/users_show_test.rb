require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:messi)
    @unactivated_user = users(:unactivated_user)
  end

  test "show should work for activated users" do
    log_in_as(@user)
    get user_path(@user)
    assert_response :success
  end

  test "show should redirect to home for unactivated users" do
    log_in_as(@user)
    get user_path(@unactivated_user)
    assert_redirected_to root_url
  end

end
