FactoryBot.define do
  factory :user do
    trait :name do
      name { 'Name' }
    end

    trait :email do
      email { 'email@example.com' }
    end
  end
end
