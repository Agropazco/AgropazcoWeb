require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_url
    assert_response :success
  end

  test "should get help" do
    get help_url
    assert_response :success
  end

  test "should get about" do
    get about_url
    assert_response :success
  end	

	test "should get impact" do
		get impact_url
		assert_response :success
	end

	test "should get partners" do
		get partners_url
		assert_response :success
	end

	test "should get terms" do
		get terms_url
		assert_response :success
	end

	
end
