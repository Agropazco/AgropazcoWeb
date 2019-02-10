require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest

	test "index including pagination" do
		get posts_path
		assert_template 'posts/index'
		assert_select 'div.pagination'
		Post.paginate(page: 1, :per_page=>10).each do |post|
			assert_select 'a[href=?]', post_path(post), text: post.title
		end
	end

end
