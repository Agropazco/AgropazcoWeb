class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Agropazco - Activación de cuenta"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Agropazco - Restablecer contraseña"
  end
end
