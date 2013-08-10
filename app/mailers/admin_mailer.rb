class AdminMailer < ActionMailer::Base

  default from: "Fab Foundation Admin Notifications <adminnotifications@fabfoundation.org>"

  def new_lab_added(lab)
    @lab = lab
    %w( john@bitsushi.com ).each do |admin|
      mail(to: admin, subject: "New Lab Added")
    end
  end

end
