FactoryBot.define do
  factory :tracking_point do
    date_point { "2025-01-03" }
    succeeded { false }
    has_data { false }
  end
end
