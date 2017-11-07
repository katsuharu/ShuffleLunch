class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.string :content
      t.integer :matching_id

      t.timestamps
    end
  end
end
