require 'test_helper'

class BuyNotificationTest < ActiveSupport::TestCase
	def setup
		@buy_notification = buy_notifications(:notification1)
	end

	test "should be valid" do
		assert @buy_notification.valid?
	end

	test "buyer should be different to vendor" do
		@buy_notification.seller_id = @buy_notification.buyer_id
		assert_not @buy_notification.valid?
	end

	test "seller should be present" do
		@buy_notification.seller_id = nil
		assert_not @buy_notification.valid?
	end

	test "buyer should be present" do
		@buy_notification.buyer_id = nil
		assert_not @buy_notification.valid?
	end

	test "post should be present" do
		@buy_notification.post_id = nil
		assert_not @buy_notification.valid?
	end

	test "message should not be blank" do
		for m in blanks do
			@buy_notification.message = m
			assert_not @buy_notification.valid?
		end
	end


end
