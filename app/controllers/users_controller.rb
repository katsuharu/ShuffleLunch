class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :show, :update, :destroy]
  before_action :correct_user,   only: [:edit, :show, :update, :destroy]

  def new
    @user = User.new
  end

  def show
    @user = User.find(current_user.id)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザー登録に成功しました。"
      redirect_to matching_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  def destroy
    User.find(current_user.id).destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_to login_path
  end

  private

    def user_params
      params.require(:user).permit(:name,
                                   :company_code,
                                   :email,
                                   :password,
                                   :password_confirmation
                                   )
    end

end