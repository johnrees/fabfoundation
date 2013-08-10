# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tool do
    lab nil
    tool_type nil
    ordinal 1
    name "MyString"
    description "MyString"
    photo "MyString"
  end
end
