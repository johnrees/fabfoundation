# require 'spec_helper'

# describe "Events" do

#   describe "all users" do

#     pending "has show page" do
#       FactoryGirl.create(:event, name: "BBQ")
#       visit root_path
#       click_link "Events"
#       click_link "BBQ"
#       page.should have_selector "h1", text: "BBQ"
#     end

#   end

#   describe "authorized user" do

#     before(:each) do
#       user_signin FactoryGirl.create(:user)
#     end

#     pending "can create event" do
#       FactoryGirl.create(:lab, name: "foodlab")
#       click_link "Events"
#       click_link "Add Event"
#       fill_in "Name", with: "BBQ"
#       select 'foodlab', from: 'Lab'
#       click_button "Create Event"
#       page.should have_selector "h1", text: "BBQ"
#     end

#     pending "can edit event" do
#       FactoryGirl.create(:event, name: 'quiet party')
#       click_link "Events"
#       click_link "quiet party"
#       click_link "Edit Event"
#       fill_in "Name", with: "RAVE!"
#       click_button "Update Event"
#       page.should have_selector "h1", text: "RAVE!"
#     end

#   end

#   describe "unauthorized user" do

#     before(:each) do
#       user_signin FactoryGirl.create(:user)
#     end

#     let(:event) { FactoryGirl.create(:event) }
#     let(:lab) { FactoryGirl.create(:lab) }

#     pending "cannot create event" do
#       visit lab_path(lab)
#       page.should_not have_link("Create Event")
#       expect{ visit new_event_path(event) }.to raise_error(ActiveRecord::RecordNotFound)
#     end

#     pending "cannot edit event" do
#       visit event_path(event)
#       page.should_not have_link("Edit Event")
#       expect{ visit edit_event_path(event) }.to raise_error(ActiveRecord::RecordNotFound)
#     end

#     pending "cannot delete event"

#   end

#   describe "not a user" do

#     pending "cannot create event"
#     pending "cannot edit event"
#     pending "cannot delete event"

#   end

# end