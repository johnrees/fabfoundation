require 'spec_helper'

describe LabApplication do

  it { should belong_to(:lab) }
  it { should belong_to(:creator) }

  it { should have_many(:referees) }
  it { should have_many(:labs).through(:referees) }

  it "should have initial state" do
    expect(FactoryGirl.build_stubbed(:lab_application).state).to eq('new')
  end

  it "has at least one referee lab"

  it "notifies creator and admins when submitted" do
    user = FactoryGirl.create(:user)
    lab_application = FactoryGirl.create(:lab_application, creator: user)
    emails = ActionMailer::Base.deliveries.map(&:to).flatten
    expect(emails).to include(user.email)
    expect(emails).to include('john@bitsushi.com')
  end

  it "notifies creator when approved" do
    user = FactoryGirl.create(:user)
    lab_application = FactoryGirl.create(:lab_application, creator: user)
    reset_email
    lab_application.approve!
    expect(last_email.to).to include(user.email)
  end

end
