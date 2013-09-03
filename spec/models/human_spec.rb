require 'spec_helper'

describe Human do

  it { should belong_to(:lab) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:lab) }

  describe "name" do
    it "uses user's name" do
      user = FactoryGirl.create(:user, first_name: 'Albert', last_name: 'Einstein')
      expect(FactoryGirl.build(:human, user: user).name).to eq('Albert Einstein')
    end

    it "uses full_name when no user present" do
      expect(FactoryGirl.build(:human, full_name: 'Alan Turing', user: nil).name).to eq('Alan Turing')
    end
  end

  describe "avatar" do

    it "uses user's avatar"

    it "uses default avatar when no user is present" do
      expect(FactoryGirl.build(:human, user: nil).avatar).to match('default-avatar')
    end

  end

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

  def avatar
    user.present? ? user.avatar_image : asset_path('/assets/default-avatar.png')
  end

end
