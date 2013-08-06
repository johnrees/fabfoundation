require 'spec_helper'

describe "Events" do

  it "has show page" do
    FactoryGirl.create(:event, name: "BBQ")
    visit root_path
    click_link "Events"
    click_link "BBQ"
    page.should have_selector "h1", text: "BBQ"
  end

  it "can create event" do
    FactoryGirl.create(:lab, name: "foodlab")
    visit root_path
    user_signin FactoryGirl.create(:user)
    click_link "Events"
    click_link "Add Event"
    fill_in "Name", with: "BBQ"
    select 'foodlab', from: 'Lab'
    click_button "Create Event"
    page.should have_selector "h1", text: "BBQ"
  end

  it "can edit event" do
    FactoryGirl.create(:event, name: 'quiet party')
    visit root_path
    user_signin FactoryGirl.create(:user)
    click_link "Events"
    click_link "quiet party"
    save_and_open_page
    click_link "Edit Event"
    fill_in "Name", with: "RAVE!"
    click_button "Update Event"

    page.should have_selector "h1", text: "RAVE!"
  end

end