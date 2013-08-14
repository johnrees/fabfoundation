# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lab_application do
    lab nil
    creator nil
    notes "MyText"
  end
end
