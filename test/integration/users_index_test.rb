require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:buyer1)
    @admin = users(:admin1)
    @unactivated_user = users(:unactivated_user)
  end

  test "index as non-admin should have only vendor users" do
    log_in_as(@user)
    get users_path
    p User.count
    assert_template 'users/index'
    User.paginate(page: 1).each do |user|
      if user.activated && user.vendor?
        assert_select 'a[href=?]', user_path(user), text: user.name
      else
        assert_select 'a[href=?]', user_path(user), text: user.name, count: 0
      end
    end
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      if user.activated
        assert_select 'a[href=?]', user_path(user), text: user.name
        unless user == @admin
          assert_select 'a[href=?]', user_path(user), text: 'eliminar'
        end
      else
        assert_select 'a[href=?]', user_path(user), text: user.name, count: 0
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end

  test "index as non-admin should not have delete links" do
    log_in_as(@user)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "index must not include unactivated users" do
    log_in_as(@user)
    get users_path
    assert_select 'a[href=?]', user_path(@unactivated_user), count: 0
  end

end

