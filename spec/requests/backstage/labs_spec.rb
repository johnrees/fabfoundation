require 'spec_helper'

describe "Labs" do

  it "disallows unauthenticated users" do
    visit backstage_root_path
    expect(current_path).to eq(login_path)
  end

  it "disallows general users" do
    user_login FactoryGirl.create(:user)
    visit backstage_root_path
    expect(current_path).to eq(root_path)
  end

  it "can edit" do
    FactoryGirl.create(:lab, name: 'newlab')
    user_login FactoryGirl.create(:admin)
    visit backstage_labs_path
    click_link 'newlab'
    fill_in "Name", with: "newerlab"
    click_button "Update Lab"
    expect(page).to have_content "Lab Updated"
  end

end
