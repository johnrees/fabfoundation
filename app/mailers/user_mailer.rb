class UserMailer < ActionMailer::Base

  default from: "Fab Foundation Notifications <notifications@fabfoundation.org>"

  def welcome(user)
    @user = user
    mail(to: "#{user} <#{user.email}>", subject: "Welcome aboard!")
  end

  def complete_registration(user)
    @user = user
    mail(to: "#{user} <#{user.email}>", subject: "Complete your registration")
  end

  def lab_submission_confirmation(lab)
    @lab = lab
    @user = lab.creator
    mail(to: "#{@user} <#{@user.email}>", subject: "Thank you for adding a Fab Lab")
  end

end
