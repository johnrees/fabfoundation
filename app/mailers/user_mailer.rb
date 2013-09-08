class UserMailer < ActionMailer::Base

  default from: "Fab Foundation Notifications <notifications@fabfoundationworld.org>"

  def welcome(user)
    @user = user
    mail(to: "#{user} <#{user.email}>", subject: "Welcome aboard!")
  end

  def password_reset(user)
    @user = user
    mail(to: "#{user} <#{user.email}>", subject: "Reset your password")
  end

  def complete_registration(user)
    @user = user
    mail(to: "#{user} <#{user.email}>", subject: "Complete your registration")
  end

  def lab_application_approval(lab_application)
    @lab_application = lab_application
    @user = lab_application.creator
    mail(to: "#{@user} <#{@user.email}>", subject: "#{@lab_application} has been approved")
  end

  def lab_application_submission(lab_application)
    @lab_application = lab_application
    @user = lab_application.creator
    mail(to: "#{@user} <#{@user.email}>", subject: "Thank you for adding a Fab Lab")
  end

end
