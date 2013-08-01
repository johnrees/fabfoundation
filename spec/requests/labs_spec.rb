require 'spec_helper'

describe "Labs" do

  it "has show page" do
    name = "MIT Media Lab"
    lab = FactoryGirl.create(:lab, name: name)
    click_link "Labs"
    click_link name
    page.should have_selector :h1, text: name
  end

  describe "creating labs" do
    it "requires authentication" do
      visit new_lab_path
      expect(current_path).to eq(login_path)
    end

    it "authenticated user can add a lab" do
      user = FactoryGirl.create(:user)
      user_login user
      click_link "Add a Lab"
      fill_in "Name", with: "New Lab"
      click_button "Add Lab"
      page.should have_selector :h1, text: "Thank you"
    end

  end

end
