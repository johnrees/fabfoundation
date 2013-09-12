require 'spec_helper'

describe Claim do

  it "user can claim lab" do
    lab = FactoryGirl.create(:lab)
    user = FactoryGirl.create(:user)
    user_signin(user)
    visit lab_path(lab)
    click_link "Claim this lab"
    fill_in "Details", with: "This is my lab"
    click_button "Submit"
    page.should have_content("Thanks for submitting your claim.")
  end

  pending "cannot claim same lab twice" do
    claimant = FactoryGirl.create(:user)
    lab = FactoryGirl.create(:lab)
    claim = FactoryGirl.create(:claim, lab: lab, user: claimant)
    user_signin(claimant)
    visit new_lab_claim_path(lab)
    current_path.should eq(root_path)
  end

  describe "managing claims" do
      let(:creator) { FactoryGirl.create(:user) }
      let(:claimant) { FactoryGirl.create(:user) }
      let(:lab) { FactoryGirl.create(:lab, creator: creator) }
      let(:claim) { FactoryGirl.create(:claim, lab: lab, user: claimant) }

    pending "regular user cannot view claims" do
      user_signin(claimant)
      visit lab_claims_path(lab)
      expect(page).to have_content(claimant.full_name)
    end

    pending "lists all claims for lab" do
      user_signin(creator)
      expect( visit lab_claims_path(lab) ).to raise_error(CanCan::AccessDenied)
    end

    pending "can approve claim" do
    end
  end

end
