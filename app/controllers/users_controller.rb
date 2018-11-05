class UsersController < ApplicationController

  include SessionsHelper # Shouldn't be needed :'v

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    puts user_params.to_yaml
    if (@user.role==1 or @user.role==2) and @user.save
      @user.send_activation_email
      flash[:info] = "Por favor revise su correo electrónico para activar su cuenta."
      redirect_to root_url
    else
      puts "Usuario invalido"
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
    puts "Deleting user"
    User.find(params[:id]).destroy
    flash[:success] = "user deleted"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Por favor inicie sesión"
        redirect_to login_url
      end
    end

    def update_user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation) # TODO No se ha verificado el nuevo email
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      puts "Name: #{current_user.name}"
      puts "is admin?: #{current_user.admin?}"
      redirect_to(root_url) unless current_user.admin?
    end
end

