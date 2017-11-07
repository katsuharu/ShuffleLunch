class AddLunchTypeToMatchings < ActiveRecord::Migration[5.1]
  def change
    add_column :matchings, :lunch_type, :integer
  end
end
