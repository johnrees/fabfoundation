class ApplicationsController < ApplicationController
  authorize_actions_for Application

  def new
    @application = current_user.applications.new
  end

  def create
    @application = current_user.applications.build application_params
    if @application.save
      redirect_to application_url(@application)
    else
      render :new
    end
  end

private

  def application_params
    params.require(:application).permit(:name, :lab_attributes)
  end

end
