class AddTimeZoneIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :time_zone_id, :integer
  end
end
