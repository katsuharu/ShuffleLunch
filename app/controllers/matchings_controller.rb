class MatchingsController < ApplicationController

  before_action :logged_in_user, :correct_user, only: [:index, :update]
  before_action :set_user, only: [:index, :update, :change]
  before_action only: :update

  def index
    case current_user.status
    when 0
      now = Time.now.strftime("%H%M")
      @end_times = Array.new
      time_zones = Array.new

      @time_zones = TimeZone.all.includes(:users).references(:users)

      TimeZone.all.each do |t|
        if t.try(:execution_time).delete(":") <= now
          @end_times << t.try(:select_time)
          @end_times << t.try(:id)
        end
      end

      @time_zones.each do |t|
        time_zones << t.try(:select_time)
        time_zones << t.try(:id)
      end
      render "end" if @end_times == time_zones
    when 1
      render "show"
    when 2
      # TODO: テーブル設計段階でリファクタする必要あり？中間テーブル設ける？
      @matching = Matching.where user1_id: current_user.id
      @matching = @matching.or Matching.where user2_id: current_user.id
      @matching = @matching.or Matching.where user3_id: current_user.id
      @matching = @matching.or Matching.where user4_id: current_user.id

      @messages = Message.includes(:user).references(:user).where matching_id: @matching[0].try(:id)
      render "room"
    when 3
      render "end"
    end
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

    def matching_params
      params.permit :time_zone_id, :lunch_type
    end

    def room_params
      params.permit :matching_id
    end

    def set_user
      @user = current_user
    end

    def valid_timezone
      timezone = TimeZone.find_by id: matching_params[:time_zone_id]
      if timezone.blank?
        flash[:danger] = Settings.matching[:not_found_time_zone]
      elsif timezone.try(:execution_time).delete(":") <= Time.now.strftime("%H%M")
        flash[:danger] = Settings.matching[:deny_time_zone]
      end
    end

end