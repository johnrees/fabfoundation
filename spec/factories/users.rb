# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@gmail.com"}
    first_name 'John'
    last_name 'Rees'
    password "password"
  end

  factory :admin, class: "User" do
    sequence(:email) { |n| "admin#{n}@gmail.com"}
    first_name 'John'
    last_name 'Rees'
    password "password"
  end

end
