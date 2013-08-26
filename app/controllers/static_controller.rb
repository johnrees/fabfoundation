class StaticController < ApplicationController

  before_filter :require_login, only: [:secret]

  def home
  end

  def developers
  end

  def secret
  end

  def privacy
  end
end
