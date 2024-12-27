class AddHabitRefToTrackingPoints < ActiveRecord::Migration[7.2]
  def change
    add_reference :tracking_points, :habit, null: false, foreign_key: true
  end
end
