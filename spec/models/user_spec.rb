require 'spec_helper'

describe User do

  it "validates email" do
    %w(testattest.com notavalidemail).each do |email|
      expect{ FactoryGirl.create(:user, email: email) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

end
