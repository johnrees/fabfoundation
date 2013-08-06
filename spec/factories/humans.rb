# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :human do
    user
    lab
    ordinal 1
    details "MyString"
    roles [:staff]
  end
end
