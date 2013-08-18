# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lab_application do
    association :lab
    association :creator, factory: :user
    # referees {[FactoryGirl.create(:referee)]}
    notes "MyText"
  end
end
