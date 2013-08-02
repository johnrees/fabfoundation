class Backstage::BackstageController < ApplicationController

  before_filter :require_login
  before_filter :authorized?
  def authorized?
    redirect_to root_url unless current_user.admin?
  end

end
