class UsersController < ApplicationController

  include SessionsHelper

  before_action :logged_in_user, only: [:sellerIndex, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @user = current_user
    if @user.admin? 
      @users = User.where(activated: true).paginate(page: params[:page])
    else
      @users = User.where("role = :role and activated = :activated", { role: "2", activated: true }).paginate(page: params[:page])
    end 
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated?
  end

  def new
    if logged_in?
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    
    if (@user.buyer? or @user.vendor?) and @user.save
      @user.send_activation_email
      flash[:info] = "Por favor revise su correo electrónico para activar su cuenta."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(update_user_params)
      flash[:success] = "Perfíl actualizado"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario borrado satisfactoriamente"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :tel, :tel_op, :address, :city)
    end

    def update_user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :tel, :tel_op, :address, :city)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
