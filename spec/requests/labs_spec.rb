require 'spec_helper'

describe Lab do

  it { should belong_to :creator }
  it { should have_many(:events) }
  it { should have_many(:humans) }
  it { should have_many(:users).through(:humans) }

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
      save_and_open_page
      expect(page).to have_link('Bart Simpson')
    end

  end

  describe "updating labs" do

    it "requires authentication" do
      lab = FactoryGirl.create(:lab)
      visit edit_lab_path(lab)
      expect(current_path).to eq(signin_path)
    end

    pending "can only be updated by lab manager"

    it "can be updated" do
      user = FactoryGirl.create(:user)
      lab = FactoryGirl.create(:lab, creator: user, state: 'approved')
      user_signin user
      visit lab_path(lab)
      click_link "Edit"
      fill_in "Fab Lab Name", with: "New Name"
      click_button "Update Lab"
      lab.reload
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
      click_link "Add a Lab"
      fill_in "Fab Lab Name", with: "New Lab"
      fill_in "City", with: "A City"
      fill_in "Address notes", with: "On the roof"
      select "United Kingdom", from: "Country"
      click_button "Add Lab"
      expect(page).to have_selector("h1", text: "Thank you")
    end

    it "confirmation email to creator after creating lab"
    it "notification email to admins after creating lab"

  end

  describe "approving labs" do

    it "unapproved labs are not visible"
    it "approved labs are visible"

  end

end
