class AddLunchTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lunch_type, :integer
  end
end
