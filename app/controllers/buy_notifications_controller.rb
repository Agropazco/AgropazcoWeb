class BuyNotificationsController < ApplicationController
	
	include SessionsHelper

	def new 
		@buy_notification = BuyNotification.new
		@buy_notification.post_id = params[:post_id]
		@buy_notification.seller_id = params[:seller_id]
	end

	def create
		user = current_user
		if user.nil?
			redirect_to login_path
			
			return
		end

		params = buy_notification_params
		params[:buyer_id] = current_user.id
		@buy_notification = BuyNotification.new(params)

		if @buy_notification.save
			flash[:info] = "Al vendedor se le notificara su mensaje"
			redirect_to root_url
		else
			flash[:danger] = @buy_notification.errors.full_messages.first
			redirect_to new_buy_notification_url(post_id: @buy_notification.post_id, seller_id: @buy_notification.seller_id)
		end
	end		

 private

 	def buy_notification_params
		params.require(:buy_notification).permit(:post_id, :message, :seller_id)
	end
end
