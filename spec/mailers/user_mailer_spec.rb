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
    expect(mail.body.encoded).to match(complete_registration_url(token: user.action_token))
  end

  pending "has lab_approval_notification" do
    lab = FactoryGirl.create(:lab)
    user = lab.creator
    mail = UserMailer.lab_approval_notification lab
    expect(mail.subject).to include("has been approved")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["notifications@fabfoundationworld.org"])
    expect(mail.body.encoded).to match(lab_url(lab))
  end

  pending "has lab_submission_confirmation" do
    lab = FactoryGirl.create(:lab)
    user = lab.creator
    mail = UserMailer.lab_submission_confirmation lab
    expect(mail.subject).to eq("Thank you for adding a Fab Lab")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["notifications@fabfoundationworld.org"])
    expect(mail.body.encoded).to match(lab_url(lab))
  end

end
