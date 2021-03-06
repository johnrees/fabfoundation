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

  describe "signed in" do

    it "cannot signup" do
      user_signin(FactoryGirl.create(:user))
      expect{ visit signup_path }.to raise_error(CanCan::AccessDenied)
    end

    it "cannot signin" do
      user_signin(FactoryGirl.create(:user))
      visit signin_path
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link("Sign in")
    end

    it "can signout" do
      user_signin(FactoryGirl.create(:user))
      click_link "Sign out"
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Signed out")
    end

  end

  describe "forgot password" do

    it "can reset password" do
      user = FactoryGirl.create(:user)
      visit signin_path
      click_link "Forgot?"
      fill_in :email, with: user.email
      click_button "Reset Password"
      user.reload
      visit edit_password_reset_url(user.forgot_password_token)
      fill_in "Password", with: "NewPassword"
      click_button "Update Password"
      click_link "Sign out"
      click_link "Sign In"
      fill_in "Email", with: user.email
      fill_in "Password", with: "NewPassword"
      click_button "Sign in"
      page.should have_link("Sign out")
    end

    pending "requires password in order to reset password" do
      user = FactoryGirl.create(:user)
      visit signin_path
      click_link "Forgot?"
      fill_in :email, with: user.email
      click_button "Reset Password"
      user.reload
      visit edit_password_reset_url(user.forgot_password_token)
      click_button "Update Password"
      page.should have_content("can't be blank")
    end

  end

  describe "signing up" do

    it "can initiate registration" do
      visit signup_path
      fill_in "First Name", with: "John"
      fill_in "Last Name", with: "Rees"
      fill_in "Email", with: "john@bitsushi.com"
      click_button "Sign up"
      expect(page).to have_content("Thanks for signing up")
      expect(last_email.to).to include("john@bitsushi.com")
    end

    describe "updating" do

      it "requires login" do
        user = FactoryGirl.create(:user)
        expect{visit edit_user_url(user.id)}.to raise_error(CanCan::AccessDenied)
      end

      it "can update settings" do
        user = FactoryGirl.create(:user)
        user_signin user
        visit edit_user_path(user)
        fill_in "Email", with: "test@test.com"
        click_button "Update"
        expect(page).to have_content("Updated")
      end
    end

    describe "changing password" do
      pending "can change password" do
        user = FactoryGirl.create(:user)
        user_signin user
        visit edit_user_path(user)
        click_link "Change Password"
        fill_in "New Password", with: "NewPass"
        fill_in "New Password Confirmation", with: "NewPass"
        click_button "Change Password"
        page.should have_content("Password updated")
      end
    end

    describe "registration" do

      it "can complete registration" do
        user = FactoryGirl.create(:user,
          first_name: "Fred",
          last_name: "Flintstone",
          email: "fred@bedrock.com")
        user.invite!
        visit complete_registration_url(user.invite_token)
        expect(page).to have_field('user_first_name', with: 'Fred')
        expect(page).to have_field('user_last_name', with: 'Flintstone')
        # expect(page).to have_field('Email', with: 'fred@bedrock.com')
        fill_in "Password", with: "hardrock"
        click_button "Finish Registration"
        expect(page).to have_content("Registration complete!")
      end

      pending "requires password" do
        user = FactoryGirl.create(:user, password: nil)
        user.invite!
        visit complete_registration_url(user.invite_token)
        click_button "Finish Registration"
        expect(page).to have_content("Password can't be blank")
      end

    end

  end

end
