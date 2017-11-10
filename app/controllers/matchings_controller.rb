class MatchingsController < ApplicationController
	before_action :logged_in_user, :correct_user, only: [:index]
	before_action :set_user, only: [:index] 
	
	max = 3
	min = 2

  def index
    entry = Entry.new(user_id: current_user.id)
    if entry.save
      flash[:success] = "シャッフルランチにエントリーしました。"
    else
      flash[:success] = "シャッフルランチにエントリーできませんでした。"
    end
  end



  private
    def set_user
      @user = current_user
    end

end