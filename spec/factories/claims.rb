# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :claim do
    association :user
    association :lab
    details "I work here"
  end
end
