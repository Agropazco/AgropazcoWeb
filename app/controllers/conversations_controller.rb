class ConversationsController < ApplicationController

  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    user = current_user
		if user.nil?
			redirect_to login_path
			return
		end

    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end
 end
