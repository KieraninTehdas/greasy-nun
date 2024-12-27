class TrackingPoint < ApplicationRecord
  belongs_to :habit

  attribute :has_data, :boolean, default: true
end
