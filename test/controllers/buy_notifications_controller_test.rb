require 'test_helper'

class BuyNotificationsControllerTest < ActionDispatch::IntegrationTest
	def setup
		@seller=users(:vendor1)
		@buyer=users(:buyer2)
		@post =posts(:apples)
	end

	test "need to log in to notificate a buy" do
		assert_no_difference 'BuyNotification.count' do
			post buy_notifications_path params: { buy_notification: {
				post_id: @post.id,
				message: "Estoy interesado en comprar manzanitas",
				seller_id: @seller.id,
				} }
			assert_redirected_to login_path
		end
	end

	test "succesful notification" do
		log_in_as @buyer
		assert_difference 'BuyNotification.count', 1 do
			post buy_notifications_path params: { buy_notification: {
				post_id: @post.id,
				message: "Estoy interesado en comprar manzanitas",
				seller_id: @seller.id,
				} }
			assert_redirected_to root_path
		end
	end

end
