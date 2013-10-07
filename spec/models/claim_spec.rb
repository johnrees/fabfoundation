require 'spec_helper'

describe Claim do
  it { should belong_to :lab }
  it { should belong_to :user }
  it { should validate_presence_of :user }
  it { should validate_presence_of :lab }
  pending { should validate_uniqueness_of(:user_id).scoped_to(:lab_id) }
  it { should validate_presence_of :details }

  it "has default state" do
    expect(FactoryGirl.build_stubbed(:claim).state).to eq('new')
  end

  it "emails lab managers when a claim is made" do
    claim = FactoryGirl.create(:claim)
    expect(last_email.to).to include(claim.lab.users.first.email)
  end

end
