require 'spec_helper'

describe LabApplication do

  describe "creating lab applications" do

    it "requires authentication" do
      visit new_lab_application_path
      expect(current_path).to eq(signin_path)
    end

    it "authenticated user can add a lab" do
      lab = FactoryGirl.create(:lab, name: 'ref', state: 'approved')
      user = FactoryGirl.create(:user)
      user_signin user
      click_link "Add a Lab"
      fill_in "Fab Lab Name", with: "New Lab"
      fill_in "City", with: "A City"
      fill_in "Address notes", with: "On the roof"
      select "United Kingdom", from: "Country"
      select "ref", from: "Referee labs"
      click_button "Submit Application"
      # save_and_open_page
      expect(page).to have_selector("h1", text: "Thank you")
      emails = ActionMailer::Base.deliveries.map(&:to).flatten
      expect(emails).to include(user.email)
      expect(emails).to include('john@bitsushi.com') #admin
    end

    it "has at least one referee" do
      expect(
        FactoryGirl.build_stubbed(:lab_application, labs: nil).errors
      ).to include("must have at least one referee")
    end

  end

end
