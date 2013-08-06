require 'spec_helper'

describe Lab do

  it { should have_many(:events) }
  it { should have_many(:humans) }
  it { should have_many(:users).through(:humans) }

  it "has show page" do
    name = "MIT Media Lab"
    lab = FactoryGirl.create(:lab, name: name)
    visit root_url
    click_link "Labs"
    click_link name
    expect(page).to have_selector("h1", text: name)
  end

  describe "updating labs" do

    it "requires authentication" do
      lab = FactoryGirl.create(:lab)
      visit edit_lab_path(lab)
      expect(current_path).to eq(signin_path)
    end

    it "can be updated" do
      lab = FactoryGirl.create(:lab)
      user = FactoryGirl.create(:user)
      user_signin user
      visit lab_path(lab)
      click_link "Edit"
      fill_in "Name", with: "New Name"
      click_button "Update Lab"
      expect(current_path).to eq lab_path(lab)
      expect(page).to have_selector("h1", text: "New Name")
    end

  end

  describe "creating labs" do

    it "requires authentication" do
      visit new_lab_path
      expect(current_path).to eq(signin_path)
    end

    it "authenticated user can add a lab" do
      user = FactoryGirl.create(:user)
      user_signin user
      click_link "Add a lab"
      fill_in "Name", with: "New Lab"
      fill_in "Address", with: "Some Address"
      fill_in "Address notes", with: "On the roof"
      click_button "Add Lab"
      expect(page).to have_selector("h1", text: "Thank you")
    end

  end

end
