class Habit < ApplicationRecord
  validates :name, presence: true

  scope :good, -> { where(start: true) }
  scope :bad, -> { where(start: false) }

  def stop?
    !start?
  end
end
