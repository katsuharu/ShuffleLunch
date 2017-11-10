class MatchingsController < ApplicationController

  before_action :logged_in_user, :correct_user, only: [:index, :update]
  before_action :set_user, only: [:index, :update, :change]
  before_action only: :update

  def index
   
  end

  def update
    if flash[:danger].blank?
      @user.update_attributes time_zone_id: matching_params[:time_zone_id], status: 1, lunch_type: matching_params[:lunch_type]
      render "show"
    else
      redirect_to :action => "index"
    end
  end

  private
    def set_user
      @user = current_user
    end

end