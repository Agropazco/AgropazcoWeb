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

	test "need to log in to report a post" do
		assert_no_difference 'PostReport.count' do
			post post_reports_path params: { post_report: {
				post_id: 1,
				topic:   "Post racista",
				message: "Este post discimina contra los pastusos" } }
			assert_redirected_to login_path
		end
	end

	test "sucessful report" do
		log_in_as @user
		assert_difference 'PostReport.count', 1 do
			post post_reports_path params: { post_report: {
				post_id: 1,
				topic:   "Post racista",
				message: "Este post discimina contra los pastusos" } }
			assert_redirected_to root_url
		end
	end

	
end
