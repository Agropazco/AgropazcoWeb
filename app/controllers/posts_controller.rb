class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create , :destroy]
	before_action :correct_user , only: :destroy 
	
	def show
		@post = Post.find_by(id: params[:id])	
		if @post.nil?
			redirect_to root_url
		else
			@comments = @post.comments
			@comment = current_user.comments.new
		end
	end

	def index
		@feed_items = Post.paginate(page: params[:page], :per_page => 10)
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post creado!"
			redirect_to root_url
		else
			@feed_items = [] 
			render 'static_pages/home'
		end
	end
	
	def destroy 
		puts "destroying post"
		@post.destroy
		flash[:success] = "Post borrado" 
		redirect_back(fallback_location:root_url)
	end 
	
	private 
		def post_params
			params.require(:post).permit(:title, :content, :picture)
		end
		def correct_user 
			if current_user.admin?
				@post = Post.find_by(id: params[:id])
			else
				@post = current_user.posts.find_by(id: params[:id])
				redirect_to root_url if @post.nil?
			end
		end
end
