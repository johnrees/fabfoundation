require 'spec_helper'

describe "Users" do

  it "should have profile page" do
    user = FactoryGirl.create(:user, username: "mickeymouse")
    visit user_path(user)
    expect(page).to have_selector("h1", text: "mickeymouse")
  end

end
