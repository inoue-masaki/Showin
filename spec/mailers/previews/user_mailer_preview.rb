class UserMailerPreview < ActionMailer::Preview

# https://〇〇/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.first
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  def password_reset
    UserMailer.password_reset
  end
end