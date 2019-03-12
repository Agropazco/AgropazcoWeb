require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
	def setup
		@seller=users(:vendor1)
		@buyer=users(:buyer2)
		@post =posts(:apples)
	end

	test "send message requires logging in" do
		assert_no_difference 'Conversation.count' do
			post conversations_path params: { conversation: {
				sender_id: @buyer.id,
				recipient_id: @seller.id
				} }
			assert_redirected_to login_path
		end
	end

	test "succesfully send message" do
		log_in_as @buyer
		assert_difference 'Conversation.count', 1 do
			post conversations_path params: {
				sender_id: @buyer.id,
				recipient_id: @seller.id
				}
			assert_redirected_to %r(.*\/conversations.*\/messages)

		end
	end

end
