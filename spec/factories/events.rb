# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    lab
    name "BBQ"
    details "A great BBQ!"
    starts_at "2013-09-02 15:00:00"
    ends_at "2013-09-02 20:00:00"
    all_day false
  end
end
