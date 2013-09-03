require "spec_helper"

describe UserMailer do

  it "has welcome" do
    user = FactoryGirl.create(:user)
    mail = UserMailer.welcome user
    expect(mail.subject).to include("Welcome")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["notifications@fabfoundationworld.org"])
    expect(mail.body.encoded).to match(root_url)
  end

  it "has complete_registration" do
    user = FactoryGirl.create(:user)
    mail = UserMailer.complete_registration user
    expect(mail.subject).to eq("Complete your registration")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["notifications@fabfoundationworld.org"])
    expect(mail.body.encoded).to match(complete_registration_url(token: user.invite_token))
  end

  it "has lab_application_approval_notification" do
    lab_application = FactoryGirl.create(:lab_application, labs: [FactoryGirl.create(:lab)])
    user = lab_application.creator
    mail = UserMailer.lab_application_approval_notification lab_application
    expect(mail.subject).to include("has been approved")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["notifications@fabfoundationworld.org"])
    expect(mail.body.encoded).to match(lab_path(lab_application.lab))
  end

  pending "has lab_application_submission_confirmation" do
    lab_application = FactoryGirl.create(:lab_application)
    user = lab_application.creator
    mail = UserMailer.lab_application_submission_notification lab_application
    expect(mail.subject).to eq("Thank you for adding a Fab Lab")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["notifications@fabfoundationworld.org"])
    expect(mail.body.encoded).to match(lab_application_url(lab_application))
  end

end
