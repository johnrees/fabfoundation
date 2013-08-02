require 'spec_helper'

describe "Events" do

  it "has show page" do
    FactoryGirl.create(:event, name: "BBQ")
    visit root_path
    click_link "Events"
    click_link "BBQ"
    page.should have_selector "h1", text: "BBQ"
  end

end