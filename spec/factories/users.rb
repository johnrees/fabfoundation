# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@gmail.com"}
    first_name 'John'
    sequence(:last_name) { |n| "Rees#{n}" }
    password "password"
  end

  factory :admin, class: "User" do
    sequence(:email) { |n| "admin#{n}@gmail.com"}
    first_name 'John'
    sequence(:last_name) { |n| "Rees#{n}" }
    password "password"
    admin true
  end

end
