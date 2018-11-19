class PostReportsController < ApplicationController

	include SessionsHelper

	def index
	  @post_reports = PostReport.all.paginate(page: params[:page])
	end

	before_action :admin_user,     only: [:show, :index, :destroy]

	def show
		@post_report = PostReport.find(params[:id])
	end

	def new
		@post_report = PostReport.new
	end

	def create
		params = post_report_params
		user = current_user
		if user.nil?
			redirect_to login_path
			return
		end
		params[:user_id] = user.id
		params[:post_id] = 1 # TODO TODO TODO

		@post_report = PostReport.new(params)
		if @post_report.save
			flash[:info] = "Gracias. Todos sus reportes serán tenidos en cuenta."
			redirect_to root_url
		else
			render 'new'
		end
	end

	def destroy
		PostReport.find(params[:id]).destroy
		flash[:success] = "El reporte de post fue borrado satisfactoriamente"
		redirect_to PostReports_url
	end


	private

		def post_report_params
			params.require(:post_report).permit(:user_id, :post_id, :topic, :message)
		end

		def admin_user
			if current_user.nil? or not current_user.admin?
				render file: "#{Rails.root}/public/404.html", layout: false, status: 404
			end
		end
end