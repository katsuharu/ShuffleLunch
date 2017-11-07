class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインして下さい。"
        redirect_to root_url
      end
    end

    def correct_user
      @user = User.find current_user.id
      redirect_to root_url unless current_user? @user
    end

end
