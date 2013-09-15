require 'spec_helper'

describe Lab do

  belongs_to :creator, class_name: "User"
  has_one :lab_application
  has_many :claims
  has_many :events
  has_many :tools
  has_many :humans
  has_many :users, through: :humans
  has_and_belongs_to_many :facilities

  describe "relationships" do
    it { should belong_to :creator }
    it { should have_one :lab_application }
    it { should have_many :claims }
    it { should have_many :events }
    it { should have_many :tools }
    it { should have_many :humans }
    it { should have_many(:users).through(:humans) }
    it { should have_and_belong_to_many :facilities }
    it { should have_and_belong_to_many :users }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  it "is valid" do
    expect( FactoryGirl.build(:lab) ).to be_valid
  end

  describe "history" do
    it "stores changes"
  end

  describe "slugs" do

    it "has slug" do
      expect( FactoryGirl.create(:lab, name: 'cool lab').slug ).to eq('cool-lab')
    end

    pending "uses slug_candidates for unique clashes" do
      lab1 = FactoryGirl.create(:lab, name: 'cool lab')
      lab2 = FactoryGirl.create(:lab, name: 'cool lab', country_code: 'fr')
      expect( lab2.slug ).to eq('cool-lab-france')
    end

  end

  it "has country method" do
    expect( FactoryGirl.build(:lab, country_code: 'fr').country ).to eq('France')
    expect( FactoryGirl.build(:lab, country_code: 'FR').country ).to eq('France')
  end

  it "has initial state"

end
