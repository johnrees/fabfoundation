require 'spec_helper'

describe LabApplication do

  it { should belong_to(:lab) }
  it { should belong_to(:creator) }

  it "should have initial state" do
    expect(FactoryGirl.build_stubbed(:lab_application).state).to eq('new')
  end

end
