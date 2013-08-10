require 'spec_helper'

describe Human do

  it { should belong_to(:lab) }
  it { should belong_to(:user) }

  describe "roles" do

    it "has roles" do
      manager = FactoryGirl.create(:human, roles: [:manager])
      expect(manager.roles).to include(:manager)
      expect(manager.roles).to_not include(:student)
    end

    it "has with_roles helper" do
      manager = FactoryGirl.create(:human, roles: [:manager])
      expect(Human.with_roles(:manager)).to include manager
      expect(Human.with_roles(:student)).to_not include manager
    end

  end

end
