class Habit < ApplicationRecord
  validates :name, presence: true

  scope :good, -> { where(start: true) }
  scope :bad, -> { where(start: false) }

  has_many :tracking_points

  def stop?
    !start?
  end

  def update_status_on_date(date_point, new_status)
    tracking_point = tracking_points.find_or_create_by(date_point: date_point)
    tracking_point.update!(succeeded: new_status)
    tracking_point
  end

  def history_between(start_date, end_date)
    points = tracking_points.where("date_point BETWEEN ? AND ?", start_date, end_date)
      .group(:date_point)
      .each_with_object({}) do |tracking_point, hash|
        hash[tracking_point.date_point.to_date] = tracking_point
    end

    (start_date..end_date).each do |date|
      unless points.has_key?(date)
        points[date] = TrackingPoint.new(date_point: date, succeeded: false, has_data: false)
      end
    end

    points.values.sort_by(&:date_point)
  end
end
