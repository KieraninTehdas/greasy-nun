FactoryBot.define do
  factory :tracking_point do
    date_time_point { "2025-01-03 23:02:52" }
    succeeded { false }
    has_data { false }
  end
end
