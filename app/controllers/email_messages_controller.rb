class EmailMessagesController < ApplicationController
	def new
		@message = EmailMessage.new
	end

	def create
		@message = EmailMessage.new(message_params)
#		message_params = params.require(:message).permit(:name, :email, :subject, :body)
#    	@message = Message.new message_params
		if @message.valid?
		  MessageMailer.contact(@message).deliver_now
		  redirect_to contact_url, notice: "Mensaje recibido, gracias!"
		else
		  render :new
		end
	end
	
	private
	
	def message_params
    	params.require(:message).permit(:name, :email, :subject, :body)
  	end
end