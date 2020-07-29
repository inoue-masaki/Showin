class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def guest_user
    current_user == User.find_by(email: 'example@railstutorial.org')
  end
  
  private
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:warning] = 'ログインしてください'
      redirect_to login_url
    end
  end
end
