# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@gmail.com"}
    sequence(:username) { |n| "user#{n}"}
    password "password"
  end

  factory :admin, class: "User" do
    sequence(:email) { |n| "admin#{n}@gmail.com"}
    username "admin"
    password "password"
  end

end
