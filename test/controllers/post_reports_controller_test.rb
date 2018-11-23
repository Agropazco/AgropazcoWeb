require 'test_helper'

class PostReportsControllerTest < ActionDispatch::IntegrationTest

	def setup()
		@user=users(:buyer1)
		@admin_user=users(:admin1)
		@post=posts(:apples)
		@post_report=post_reports(:buyer2_report_of_post1_of_vendor1)
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
				post_id: @post.id,
				topic:   "Post racista",
				message: "Este post discimina contra los pastusos" } }
			assert_redirected_to root_url
		end
	end

	test "non-admin can not delete a report" do
		log_in_as @user
		assert_no_difference 'PostReport.count' do
			delete post_report_path(@post_report)
		end
	end

	test "admin can delete a post report" do 
		log_in_as @admin_user 
		assert_difference 'PostReport.count', -1 do
			delete post_report_path(@post_report)
		end
	end
	
end
