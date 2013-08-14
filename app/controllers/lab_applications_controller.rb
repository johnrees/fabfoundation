class LabApplicationsController < ApplicationController


  def thank_you
  end
  # authority_actions thank_you: 'create'

  def new
    @lab_application = current_user.lab_applications.new
    lab = @lab_application.build_lab
    lab.tools.build
  end

  def create
    @lab_application = current_user.lab_applications.create lab_application_params
    if @lab_application.save
      redirect_to lab_applications_thank_you_url
    else
      render :new
    end
  end

private

  def lab_application_params
    params.require(:lab_application).permit!
  end

end
