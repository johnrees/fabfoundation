# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :referee do
    association :lab
    association :lab_application
  end
end
