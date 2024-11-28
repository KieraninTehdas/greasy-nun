class Habit < ApplicationRecord
  validates :name, presence: true
end
