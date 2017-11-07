class CreateTimeZones < ActiveRecord::Migration[5.1]
  def change
    create_table :time_zones do |t|
      t.string :select_time

      t.timestamps
    end
  end
end
