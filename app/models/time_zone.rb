class TimeZone < ApplicationRecord
  has_many :users

  def get_users lunch_type
    users.where lunch_type: lunch_type
  end
end
