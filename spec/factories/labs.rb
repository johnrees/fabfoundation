# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lab do
    sequence(:name) { |n| "MIT Media Lab #{n}" }
    address_notes "At MIT"
    city "Boston"
    country_code "US"
    kind [:supernode]
  end
end
