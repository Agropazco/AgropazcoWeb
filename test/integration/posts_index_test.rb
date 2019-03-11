require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest
	
	def setup
    @user = users(:buyer1)
	end
	
	test "index including pagination" do
		log_in_as @user
		get posts_path
		assert_template 'posts/index'
		assert_select 'div.pagination'
		Post.paginate(page: 1, :per_page=>10).each do |post|
			assert_select 'a[href=?]', post_path(post), text: post.title
		end
	end

end
