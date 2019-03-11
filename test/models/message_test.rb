require 'test_helper'

class MessageTest < ActiveSupport::TestCase
	def setup
		@message = messages(:message1)
	end

	test "should be valid" do
		assert @message.valid?
	end

	test "message should be not be nil" do
		@message.body = nil
		assert_not @message.valid?
	end

	test "message should not be blank" do
		@message.body = ""
		assert_not @message.valid?
	end

	test "user should be not be nil" do
		@message.user_id = nil
		assert_not @message.valid?
	end

	test "conversation id should not be nil" do
		@message.conversation_id = ""
		assert_not @message.valid?
	end
end
