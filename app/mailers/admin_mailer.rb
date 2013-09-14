class AdminMailer < ActionMailer::Base

  default from: "Fab Foundation Admin Notifications <adminbot@fabfoundationworld.org>"

  def lab_application_submission(lab)
    @lab = lab
    %w( john@bitsushi.com ).each do |admin|
      mail(to: admin, subject: "New Lab Application")
    end
  end

end
