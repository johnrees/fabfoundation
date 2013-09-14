require "spec_helper"

describe AdminMailer do

  it "has lab_application_submission" do
    lab = FactoryGirl.create(:lab)
    mail = AdminMailer.lab_application_submission lab
    expect(mail.subject).to include("New Lab Application")
    expect(mail.to).to eq(["john@bitsushi.com"])
    expect(mail.from).to eq(["adminbot@fabfoundationworld.org"])
    expect(mail.body.encoded).to match( backstage_lab_url(lab) )
  end

end
