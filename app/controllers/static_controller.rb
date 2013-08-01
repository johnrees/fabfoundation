class StaticController < ApplicationController

  before_filter :require_login, only: [:secret]

  def home
  end

  def secret
  end
end
