class ChangeTrackingPointDateTimePointToDatePoint < ActiveRecord::Migration[7.2]
  def change
    reversible do |direction|
      change_table :tracking_points do |table|
        direction.up do 
          table.change :date_time_point, :date
          table.rename :date_time_point, :date_point
        end

        direction.down do
          table.change :date_time_point, :datetime
          table.rename :date_point, :date_time_point
        end
      end
    end
  end
end
