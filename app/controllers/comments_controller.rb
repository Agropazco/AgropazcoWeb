class CommentsController < ApplicationController

  def create
    puts "#{comment_params}"
    @user = User.find(comment_params[:user_id])
    @comment = @user.comments.new(comment_params)
    if @comment.save!
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end
end
