class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Showinよりアカウント有効化のためのメールを届けました"
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Showinよりパスワード再設定のためのメールを届けました"
  end
end