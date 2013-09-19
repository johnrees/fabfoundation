require 'spec_helper'

describe Lab do

  describe "map" do
    it "lists all labs" do
      visit root_path
      click_link "Labs"
      click_link "Map"
      page.should have_css "#map"
    end
  end

  describe "show page" do
    it "has show page" do
      name = "MIT Media Lab"
      lab = FactoryGirl.create(:lab, name: name, state: 'approved')
      visit root_url
      click_link "Labs"
      click_link name
      expect(page).to have_selector("h1", text: name)
    end

    pending "shows humans" do
      user = FactoryGirl.create(:user, first_name: 'Bart', last_name: 'Simpson')
      lab = FactoryGirl.create(:lab, creator: user, state: 'approved')
      visit lab_url(lab)
      expect(page).to have_link('Bart Simpson')
    end

    it "can only view approved labs" do
      lab = FactoryGirl.create(:lab)
      expect{ visit lab_path(lab) }.to raise_error(ActiveRecord::RecordNotFound)
    end

  end

  describe "updating labs" do

    it "requires authentication" do
      lab = FactoryGirl.create(:lab)
      visit edit_lab_path(lab)
      expect(current_path).to eq(signin_path)
    end

    it "cannot be updated unless creator" do
      lab = FactoryGirl.create(:lab)
      user = FactoryGirl.create(:user)
      user_signin user
      expect{ visit edit_lab_path(lab) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "can be updated" do
      user = FactoryGirl.create(:user)
      lab = FactoryGirl.create(:lab, state: 'approved')
      user.labs << lab
      user_signin user
      visit lab_path(lab)
      click_link "Edit Lab"
      fill_in "Fab Lab Name", with: "New Name"
      click_button "Update Lab"
      lab.reload
      expect(current_path).to eq lab_path(lab)
      expect(page).to have_selector("h1", text: "New Name")
    end

  end

end
