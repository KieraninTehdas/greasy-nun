class CreateTrackingPoints < ActiveRecord::Migration[7.2]
  def change
    create_table :tracking_points do |t|
      t.datetime :date_time_point
      t.boolean :succeeded

      t.timestamps
    end
  end
end
