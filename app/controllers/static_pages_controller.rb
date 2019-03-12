class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def contact
  end

  def about
  end

	def impact
	end

	def partners
  end
  
  def faq
  end

	def terms
	end

	def posts
	end

end
