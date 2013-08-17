class SessionsController < ApplicationController

  layout 'sessions'
  before_filter :require_new_user, only: [:new, :create]

  def create
    user = User.find_by email: params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to params[:goto], notice: "Signed in!", only_path: true
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end