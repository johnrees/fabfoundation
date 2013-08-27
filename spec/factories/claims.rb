# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :claim do
    user nil
    lab nil
    state "MyString"
  end
end
