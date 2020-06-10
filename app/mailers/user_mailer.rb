class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "【重要】Lantern Lanternよりアカウント有効化のためのメールを届けました"
  end

  # この部分は次章
  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end
end