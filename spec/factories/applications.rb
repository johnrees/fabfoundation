# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :application do
    lab nil
    creator nil
    state "MyText"
    notes "MyText"
  end
end
