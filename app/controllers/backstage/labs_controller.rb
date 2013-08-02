class Backstage::LabsController < Backstage::BackstageController

  authorize_actions_for Lab

  def index
    @labs = Lab.all
  end

  def edit
    @lab = Lab.find(params[:id])
  end

  def update
    @lab = Lab.find(params[:id])
    if @lab.update_attributes lab_params
      redirect_to backstage_labs_url, notice: "Lab Updated"
    else
      render :edit
    end
  end

private

  def lab_params
    params.require(:lab).permit(:name, :address)
  end

end
