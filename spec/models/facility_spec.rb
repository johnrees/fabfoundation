require 'spec_helper'

describe Facility do

  describe "relationships" do
    it { should have_and_belong_to_many :labs }
  end

  it "should have default_scope" do
    a = FactoryGirl.create(:facility, name: 'zebra')
    b = FactoryGirl.create(:facility, name: 'aardvark')
    expect( Facility.all ).to eq [b,a]
  end

  it "should have icon" do
    expect( FactoryGirl.build(:facility, name: 'cool facility').icon ).to eq("facilities/cool-facility.svg")
  end

end
