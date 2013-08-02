require 'spec_helper'

describe User do

  it "validates email" do
    %w(testattest.com notavalidemail).each do |email|
      expect{ FactoryGirl.create(:user, email: email) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  it "has admin" do
    expect(FactoryGirl.create(:user)).to_not be_admin
    expect(FactoryGirl.create(:admin)).to be_admin
  end

end
