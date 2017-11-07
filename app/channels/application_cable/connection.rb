module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user, :matching_id

    def connect
      self.current_user = find_verified_user
      self.matching_id = get_matching_id
    end

    protected

    def find_verified_user
      if verified_user = User.find_by(id: session['user_id'])
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    def session
      cookies.encrypted[Rails.application.config.session_options[:key]]
    end

    def get_matching_id
      matching = Matching.where user1_id: current_user.id
      matching = matching.or Matching.where user2_id: current_user.id
      matching = matching.or Matching.where user3_id: current_user.id
      matching = matching.or Matching.where user4_id: current_user.id
      matching[0].try(:id)
    end
  end
end
