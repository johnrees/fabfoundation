class UserMailer < ActionMailer::Base

  default from: "Fab Foundation Notifications <notifications@fabfoundationworld.org>"

  def welcome(user)
    @user = user
    mail(to: "#{user} <#{user.email}>", subject: "Welcome aboard!")
  end

  def complete_registration(user)
    @user = user
    mail(to: "#{user} <#{user.email}>", subject: "Complete your registration")
  end

  def lab_approval_notification(lab)
    @lab = lab
    @user = lab.creator
    mail(to: "#{@user} <#{@user.email}>", subject: "#{@lab} has been approved")
  end

  def lab_submission_confirmation(lab)
    @lab = lab
    @user = lab.creator
    mail(to: "#{@user} <#{@user.email}>", subject: "Thank you for adding a Fab Lab")
  end

end
