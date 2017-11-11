class MatchingsController < ApplicationController
	before_action :logged_in_user, :correct_user, only: [:index]
	before_action :set_user, only: [:index] 
	
	@@entry_id = 0
	@@pair_no = 0

  	def index
  	end

	def entry
		@@entry_id += 1
		p @@entry_id
		User.where(user_id: current_user.id).update(entry_id: @@entry_id)
	  	flash[:success] = "シャッフルランチにエントリーしました。"

		if @@entry_id % 3 == 0
			@@pair_no += 1
			p @@pair_no
			User.where(entry_id: @@entry_id-2 .. @@entry_id).update(pair_id: @@pair_no)

	  		render action: 'show'
	  	end
	end

	def check
		# @entry = Entry.where(pair_no: )
		# @pair = User.find
	end

	private
	def set_user
		@user = current_user
	end

end