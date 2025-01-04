FactoryBot.define do
  factory :habit do
    name { "MyString" }
    start { false }

    trait :good do
      start { true }
    end

    trait :bad do
      start { false }
    end
  end
end
