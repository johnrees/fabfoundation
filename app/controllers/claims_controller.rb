class ClaimsController < ApplicationController

  def index
    @lab = Lab.friendly.find(params[:lab_id])
    @claims = @lab.claims
    authorize! :manage, @lab
  end

  def new
    @lab = Lab.friendly.find(params[:lab_id])
    @claim = current_user.claims.build(lab: @lab)
    authorize! :claim, @lab
  end

  def create
    @lab = Lab.friendly.find(params[:lab_id])
    @claim = current_user.claims.new(claim_params)
    authorize! :claim, @lab
    if @claim.save
      redirect_to lab_url(@lab), notice: "Thanks for submitting your claim."
    else
      render 'new'
    end
  end

  def destroy
    @lab = Lab.friendly.find(params[:lab_id])
    @claim = Claim.find(params[:id])
    authorize! :destroy, @claim
    @claim.delete
    redirect_to lab_claims_path(@lab), notice: "Claim removed"
  end

  def approve
    @lab = Lab.friendly.find(params[:lab_id])
    @claim = Claim.find(params[:id])
    @claim.approve!
    redirect_to lab_claims_url(@lab), notice: "Claim Approved"
  end

private

  def claim_params
    params.require(:claim).permit(:lab_id, :details)
  end

end
