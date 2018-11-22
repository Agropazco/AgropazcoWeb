class SessionsController < ApplicationController

  include SessionsHelper

  def new
    redirect_to root_url unless current_user.nil?
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message = "Su cuenta aún no ha sido activada."
        message += "Para obtener el link de activación revise su correo."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Usuario o contraseña inválido'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

