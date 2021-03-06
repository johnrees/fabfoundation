class LabApplicationsController < ApplicationController

  before_filter :require_login

  def new
    @lab_application = current_user.lab_applications.new
    lab = @lab_application.build_lab
    lab.tools.build
    authorize! :new, @lab_application
  end

  def create
    @lab_application = current_user.lab_applications.create(lab_application_params)
    @lab_application.lab.creator = current_user
    authorize! :create, @lab_application
    if @lab_application.save
      redirect_to lab_applications_thank_you_url
    else
      render :new
    end
  end

  def thank_you
  end

private

  def lab_application_params
    params.require(:lab_application).permit!
  end

end
