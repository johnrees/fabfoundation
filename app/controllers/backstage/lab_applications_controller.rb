class Backstage::LabApplicationsController < Backstage::BackstageController

  def show
    @lab_application = LabApplication.find(params[:id])
  end

  def index
    @q = LabApplication.unscoped.to_moderate.order('lab_applications.id desc').includes(:referees, :creator).search(params[:q])
    @lab_applications = @q.result.page(params[:page])
    # (distinct: true)
  end

  def edit
    @lab_application = LabApplication.unscoped.find(params[:id])
  end

  def update
    @lab_application = LabApplication.unscoped.find(params[:id])
    if @lab_application.update_attributes lab_application_params
      redirect_to backstage_lab_applications_url, notice: "LabApplication Updated"
    else
      render :edit
    end
  end

  def destroy
    @lab_application = LabApplication.unscoped.find(params[:id])
    @lab_application.delete
    redirect_to backstage_lab_applications_url, notice: "LabApplication Deleted"
  end

private

  def lab_application_params
    params.require(:lab_application).permit!
  end

end
