require 'spec_helper'

describe User do

  describe "relationships" do
    it { should have_many(:events)} #creator
    # pending { should have_many(:labs)} #creator
    # it { should have_many(:labs).through(:humans) }

    it { should have_many(:labs).through(:labs_users) }

    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should have_many :claims}
  end

  it "generates token before creation"
  it "sends complete_registration mailer after creation"

  it "has managed_labs scope"

  it "has initial state" do
    expect(FactoryGirl.build_stubbed(:user)).to be_new
  end

  it "has full_name method" do
    expect(
      FactoryGirl.build_stubbed(:user, first_name: 'Donald', last_name: 'Duck').full_name
    ).to eq("Donald Duck")
  end

  it "has avatar_image for avatar" do
    expect(
      FactoryGirl.build_stubbed(:user, avatar: 'http://google.com/logo.gif').avatar_image
    ).to eq("http://google.com/logo.gif")
  end

  it "has default avatar_image" do
    expect(
      FactoryGirl.build_stubbed(:user).avatar_image
    ).to match('default_user')
  end

  pending "validates password" do
    %w(2sht).each do |password|
      expect{
        FactoryGirl.create(:user, password: password)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  it "validates email" do
    %w(testattest.com notavalidemail).each do |email|
      expect{
        FactoryGirl.create(:user, email: email)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  it "has admin" do
    expect( User.new(admin: false) ).to_not be_admin
    expect( User.new(admin: true) ).to be_admin
  end

  pending "has managable_labs" do
    user = FactoryGirl.create(:user)
    unmanaged = FactoryGirl.create(:lab)
    managed = FactoryGirl.create(:lab, creator: user)
    expect(user.managed_labs).to eq([managed])
    expect(managed).to be_updatable_by(user)
    expect(unmanaged).to_not be_updatable_by(user)
  end

end
