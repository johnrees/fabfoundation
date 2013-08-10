# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lab do
    name "MIT Media Lab"
    address "Boston"
    address_notes "At MIT"
    state_code "MA"
    country_code "US"
    kind [:supernode]
  end
end
