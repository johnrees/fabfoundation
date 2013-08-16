require 'spec_helper'

describe LabApplication do

  describe "creating lab applications" do

    it "requires authentication" do
      visit new_lab_application_path
      expect(current_path).to eq(signin_path)
    end

    it "authenticated user can add a lab" do
      user = FactoryGirl.create(:user)
      user_signin user
      click_link "Add a Lab"
      fill_in "Fab Lab Name", with: "New Lab"
      fill_in "City", with: "A City"
      fill_in "Address notes", with: "On the roof"
      select "United Kingdom", from: "Country"
      click_button "Submit Application"
      expect(page).to have_selector("h1", text: "Thank you")
    end

    it "confirmation email to creator after creating lab"
    it "notification email to admins after creating lab"

  end

end
