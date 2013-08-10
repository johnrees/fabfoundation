class Backstage::LabsController < Backstage::BackstageController

  authorize_actions_for Lab

  def show
  end

  def index
    @q = Lab.search(params[:q])
    @labs = @q.result(distinct: true)
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

  def destroy
    @lab = Lab.find(params[:id])
    @lab.delete
    redirect_to backstage_labs_url, notice: "Lab Deleted"
  end

private

  def lab_params
    params.require(:lab).permit!#(:name, :address, :country_code)
  end

end
