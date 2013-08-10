class Backstage::BackstageController < ApplicationController

  before_filter :require_login
  before_filter :authorized?
  layout 'backstage'

  def authorized?
    redirect_to root_url, alert: "You cannot go there sorry" unless current_user.admin?
  end

end
