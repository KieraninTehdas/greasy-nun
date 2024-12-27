class Habit < ApplicationRecord
  validates :name, presence: true

  scope :good, -> { where(start: true) }
  scope :bad, -> { where(start: false) }

  has_many :tracking_points

  def stop?
    !start?
  end

  def history_between(start_date, end_date)
    points = tracking_points.where("? <= date_time_point <= ?", start_date, end_date).group_by(&:date_time_point)

    (start_date.to_date..end_date.to_date).each do |date|
      unless points.has_key?(date)
        points[date] = TrackingPoint.new(date_time_point: date, succeeded: false, has_data: false)
      end
    end

    points.values
  end
end
