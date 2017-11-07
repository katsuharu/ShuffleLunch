class AddExecutionTimeToTimeZones < ActiveRecord::Migration[5.1]
  def change
    add_column :time_zones, :execution_time, :string
  end
end
