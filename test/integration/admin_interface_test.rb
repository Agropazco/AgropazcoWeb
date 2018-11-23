require 'test_helper'

class AdminInterfaceTest < ActionDispatch::IntegrationTest
  def setup 
    @admin = users(:admin1)
    @vendor = users(:vendor1)
    @buyer = users(:buyer1)
    @users = [@admin, @vendor, @buyer]
  end
  test "Admin header" do
    for user in @users do 
      log_in_as(user)
      get root_path 
      if user.admin?
       assert_select "a[href=?]", post_reports_url, count: 1 
      else 
        assert_select "a[href=?]", post_reports_url, count: 0
      end
    end
  end
end
