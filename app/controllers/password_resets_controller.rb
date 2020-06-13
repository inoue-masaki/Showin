class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def edit
  end
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "再設定用のURLを入力したメールに送信しました"
      redirect_to root_url
    else
      flash[:danger] = "お使いのメールアドレスは登録されていません"
      render 'new'
    end
  end
  
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "パスワードの再設定が完了しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
    private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
        flash[:danger] = "無効なURLです。再度メールアドレスを入力してください"
        redirect_to new_password_reset_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワード再設定URLの有効期限が過ぎています。再度メールアドレスを入力してください"
        redirect_to new_password_reset_url
      end
    end
end
