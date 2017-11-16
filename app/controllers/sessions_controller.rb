class SessionsController < ApplicationController

  def new
    redirect_to matching_path if current_user.present?
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticated?(:password, params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or '/matching'
    else
      flash.now[:danger] = Settings.session[:not_found]
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end