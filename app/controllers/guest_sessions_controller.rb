class GuestSessionsController < ApplicationController

  def create
    user = User.find_by(email: 'example@railstutorial.org')
    log_in(user)
    flash[:success] = 'ゲストユーザーでログインしました'
    flash[:warning] = 'よろしくお願いします！'
    redirect_to user
  end
end
