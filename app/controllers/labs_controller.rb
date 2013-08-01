class LabsController < ApplicationController

  def thank_you
  end

  def new
    @lab = Lab.new
  end

  def create
    @lab = Lab.create lab_params
    if @lab.save
      redirect_to labs_thank_you_url
    else
      render :new
    end
  end

  def index
    @labs = Lab.all
  end

  def show
    @lab = Lab.find(params[:id])
  end

private

  def lab_params
    params.require(:lab).permit(:name, :address)
  end

end
