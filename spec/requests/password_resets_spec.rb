require 'spec_helper'

describe "PasswordReset" do

  describe "normal users" do

    it "sends password_reset email" do
      user = FactoryGirl.create(:user, email: 'forgotpass@gmail.com')
      visit signin_path
      click_link "Forgot?"
      fill_in "Email", with: "forgotpass@gmail.com"
      click_button "Reset Password"
      expect(page).to have_content "password reset instructions have been sent"
      expect(last_email.to).to eq(["forgotpass@gmail.com"])
    end

    it "can reset password" do
      user = FactoryGirl.create(:user)
      visit new_password_reset_path
      fill_in "Email", with: user.email
      click_button "Reset Password"
      user.reload
      visit edit_password_reset_url(user.forgot_password_token)
      fill_in "user_password", with: "newpassword"
      # fill_in "Password confirmation", with: "newpassword"
      click_button "Update Password"
      expect(page).to have_content("Password has been reset")
    end

  end

  describe "naughty users" do

    it "see password reset email sent even if no email match" do
      visit new_password_reset_path
      fill_in "Email", with: "notauser@hotmail.com"
      click_button "Reset Password"
      expect(page).to have_content "password reset instructions have been sent"
      expect(ActionMailer::Base.deliveries).to be_empty
    end

    it "can only reset if a reset was requested"

  end

end
