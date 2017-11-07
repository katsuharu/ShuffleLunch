class ChangeUserStatusDefault < ActiveRecord::Migration[5.1]
  def change
    change_column(:users, :status, :integer, :null => 0)
  end
end
