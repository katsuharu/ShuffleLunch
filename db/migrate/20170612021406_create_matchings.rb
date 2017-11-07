class CreateMatchings < ActiveRecord::Migration[5.1]
  def change
    create_table :matchings do |t|
      t.integer :user1_id
      t.integer :user2_id
      t.integer :user3_id
      t.integer :user4_id

      t.timestamps
    end
  end
end
