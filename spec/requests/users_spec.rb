require 'spec_helper'

describe "Users" do

  it "has profile page" do
    user = FactoryGirl.create(:user, first_name: 'Homer', last_name: 'Simpson')
    visit user_path(user)
    expect(page).to have_selector("h1", text: "Homer Simpson")
  end

  it "can signup" do
    visit root_path
    click_link "Sign In"
    click_link "Sign up"
    fill_in "First Name", with: 'John'
    fill_in "Last Name", with: 'Rees'
    fill_in "Email", with: 'john@bitsushi.com'
    click_button "Sign up"
    page.should have_content("check your email")
  end

  it "cannot signup when signed in"
  it "cannot signin when signed in"
  it "can complete signup"

end
