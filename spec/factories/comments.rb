# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    ancestry "MyString"
    content "MyText"
    commentable ""
  end
end
