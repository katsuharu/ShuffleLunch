class MatchingsController < ApplicationController
	before_action :logged_in_user, :correct_user, only: [:index]
	before_action :set_user, only: [:index] 
	
	@@entry_id = 0;
	@@pair_no = 0;

  	def index
  	end

	def entry
		entry = Entry.new(user_id: current_user.id)
		
		if entry.save
			@@entry_id += 1;
			if @@entry_id % 3 == 0
				@@pair_no++;
				# Entry.where(entry_id: @@entry_id).update(pair_no: @@pair_no)

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