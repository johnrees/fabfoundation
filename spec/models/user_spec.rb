require 'spec_helper'

describe User do

  it { should have_many(:labs).through(:humans) }

  it "validates email" do
    %w(testattest.com notavalidemail).each do |email|
      expect{ FactoryGirl.create(:user, email: email) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  it "has admin" do
    expect(FactoryGirl.create(:user)).to_not be_admin
    expect(FactoryGirl.create(:admin)).to be_admin
  end

  it "has managable_labs" do
    user = FactoryGirl.create(:user)
    unmanaged = FactoryGirl.create(:lab)
    managed = FactoryGirl.create(:lab, users: [user])
    expect(user.managed_labs).to eq([managed])
    expect(managed).to be_updatable_by(user)
    expect(unmanaged).to_not be_updatable_by(user)
  end

end
