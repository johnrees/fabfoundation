require 'spec_helper'

describe Claim do
  it { should belong_to :lab }
  it { should belong_to :user }
  it { should validate_presence_of :user }
  it { should validate_presence_of :lab }
  it { should validate_uniqueness_of(:user_id).scoped_to(:lab_id) }
  it { should validate_presence_of :details }

  it "has default state" do
    expect(FactoryGirl.build_stubbed(:claim).state).to eq('new')
  end

end
