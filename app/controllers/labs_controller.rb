class LabsController < ApplicationController

  before_filter :require_login, except: [:index, :show]
  authorize_actions_for Lab
  authority_actions thank_you: 'create'
  authority_actions map: 'read'

  def map
    @q = Lab.search(params[:q])
    @labs = @q.result(distinct: true)
  end

  def index
    @q = Lab.search(params[:q])
    @labs = @q.result(distinct: true).page(params[:page])
    respond_to do |format|
      format.html
      format.json { render json: @labs = Lab.all.to_json }
    end
  end

  def thank_you
  end

  def new
    @lab = Lab.new
  end

  def edit
    @lab = current_user.labs.find(params[:id])
    authorize_action_for(@lab)
  end

  def update
    @lab = current_user.labs.find(params[:id])
    if @lab.update_attributes lab_params
      redirect_to lab_url(@lab), notice: "Lab Updated"
    else
      render :edit
    end
  end

  def create
    @lab = current_user.labs.create lab_params
    if @lab.save
      redirect_to labs_thank_you_url
    else
      render :new
    end
  end

  def show
    @lab = Lab.find(params[:id])
    @lab.geocode
    @days = %w(monday tuesday wednesday thursday friday saturday sunday)
  end

private

  def lab_params
    params.require(:lab).permit(:name, :address)
  end

end
