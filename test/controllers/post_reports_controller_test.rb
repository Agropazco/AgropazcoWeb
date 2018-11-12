require 'test_helper'

class PostReportsControllerTest < ActionDispatch::IntegrationTest

	def setup()
		@user=users(:messi)
		@admin_user=users(:master)
		@post_report=post_reports(:ronaldo_report_juanValdez)
	end

	test "show should work for admin" do
		log_in_as @admin_user
		get post_report_path(@post_report)
		puts("aqui admin USER")
		puts(@admin_user.to_yaml)
		assert_response :success
	end

	test "show should not work for non admin" do
		log_in_as @user
		get post_report_path(@post_report)
		assert_response :missing
	end
	
	test "show should not work without logging in" do
		get post_report_path(@post_report)
		assert_response :missing
	end
	
end
