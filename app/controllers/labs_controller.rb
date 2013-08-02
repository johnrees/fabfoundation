class LabsController < ApplicationController

  before_filter :require_login, except: [:index, :show]
  authorize_actions_for Lab
  authority_actions thank_you: 'create'

  def index
    @labs = Lab.all
  end

  def thank_you
  end

  def new
    @lab = Lab.new
  end

  def edit
    @lab = Lab.find(params[:id])
    authorize_action_for(@lab)
  end

  def update
    @lab = Lab.find(params[:id])
    if @lab.update_attributes lab_params
      redirect_to lab_url(@lab), notice: "Lab Updated"
    else
      render :edit
    end
  end

  def create
    @lab = Lab.create lab_params
    if @lab.save
      redirect_to labs_thank_you_url
    else
      render :new
    end
  end

  def show
    @lab = Lab.find(params[:id])
  end

private

  def lab_params
    params.require(:lab).permit(:name, :address)
  end

end
