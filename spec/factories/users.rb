FactoryBot.define do
  factory :user do
    name { 'Name' }
    sequence(:email) { |n| "email_#{n}@ymtk.com" }

    trait :name do
      name { 'Name' }
    end

    trait :email do
      email { 'email@example.com' }
    end
  end
end
