class MatchingsController < ApplicationController

  before_action :logged_in_user, :correct_user, only: [:index, :update]
  before_action :set_user, only: [:index, :update, :change]
  before_action only: :update

  def index
    entry = Entry.new(user_id: current_user.id)
    if entry.save
      flash[:success] = "シャッフルランチにエントリーしました。"
      redirect_to root_url      
    else
      redirect_to matching_path
    end
  end

  def update
    if flash[:danger].blank?
      render :action "show"
    else
      redirect_to :action => "index"
    end
  end

  private
    def set_user
      @user = current_user
    end

end