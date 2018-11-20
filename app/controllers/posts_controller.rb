class PostsController < ApplicationController
    before_action :logged_in_user, only: [:create , :destroy]

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = [] 
            render 'static_pages/home'
        end
    end
    
    def destroy 
    end 
    
    private 
        def post_params
            params.require(:post).permit(:title, :content)
        end
end
