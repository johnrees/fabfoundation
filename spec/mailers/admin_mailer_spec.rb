require "spec_helper"

describe AdminMailer do

  it "has new_lab_added" do
    lab = FactoryGirl.create(:lab)
    mail = AdminMailer.new_lab_added lab
    expect(mail.subject).to include("New Lab Added")
    expect(mail.to).to eq(["john@bitsushi.com"])
    expect(mail.from).to eq(["adminbot@fabfoundationworld.org"])
    expect(mail.body.encoded).to match( backstage_lab_url(lab) )
  end

end
