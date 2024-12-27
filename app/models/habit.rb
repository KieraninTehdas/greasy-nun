class Habit < ApplicationRecord
  validates :name, presence: true

  scope :good, -> { where(start: true) }
  scope :bad, -> { where(start: false) }

  has_many :tracking_points

  def stop?
    !start?
  end
end
