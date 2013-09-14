require 'spec_helper'

describe LabApplication do

  describe "creating lab applications" do

    it "requires authentication" do
      visit new_lab_application_path
      expect(current_path).to eq(signin_path)
    end

    it "authenticated user can add a lab" do
      referee = FactoryGirl.create(:lab, name: 'ref', state: 'approved')
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

  end

  describe "approving lab applications" do

    pending "notifies creator" do
      user = FactoryGirl.create(:user)
      lab_application = FactoryGirl.create(:lab_application, creator: user)
    end

  end

end
