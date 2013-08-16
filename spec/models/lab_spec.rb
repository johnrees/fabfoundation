require 'spec_helper'

describe Lab do

  # it { should belong_to :creator }
  # it { should have_many(:events) }
  # it { should have_many(:humans) }
  # it { should have_many(:users).through(:humans) }

  it { should belong_to :creator }
  it { should validate_presence_of :name }
  it { should have_many :events }
  it { should have_many :humans }
  it { should have_many(:users).through(:humans) }
  it { should have_and_belong_to_many(:referee_labs) }

  it "is valid" do
    expect( FactoryGirl.build(:lab) ).to be_valid
  end

  it "has country method"

  it "notifies creator after creation"

  it "notifies admins after creation"

  it "has initial state"

end
