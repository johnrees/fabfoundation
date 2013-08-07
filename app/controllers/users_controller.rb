class UsersController < ApplicationController

  authorize_actions_for User

  def new
    @user = User.new
    render layout: 'sessions'
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

private

  def user_params
    params.require(:user).permit(:password, :email)
  end

end
