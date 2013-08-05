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
    visit root_path
    user_signin FactoryGirl.create(:user)
    click_link "Events"
    click_link "Add Event"
    fill_in "Name", with: "BBQ"
    click_button "Create Event"
    page.should have_selector "h1", text: "BBQ"
  end

end