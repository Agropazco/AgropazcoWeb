require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
	def setup
		@conversation = conversations(:conversation1)
	end

	test "should be valid" do
		assert @conversation.valid?
	end

	test "sender should be different to recipient" do
		@conversation.sender_id = @conversation.recipient_id
		assert_not @conversation.valid?
	end

	test "sender should be present" do
		@conversation.sender_id = nil
		assert_not @conversation.valid?
	end

	test "recipient should be present" do
		@conversation.recipient_id = nil
		assert_not @conversation.valid?
	end


end
