class PasswordResetsController < ApplicationController

  before_filter :require_new_user

  def create
    user = User.find_by(email: params[:email])
    user.send_password_reset if user
    redirect_to root_url, notice: "If that email was in our database, password reset instructions have been sent to it."
  end

  def edit
    @user = User.find_by!(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by!(password_reset_token: params[:id])
    if @user.update_attributes password_reset_params
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Password has been reset!"
    else
      render :edit
    end
  end

private

  def password_reset_params
    params.require(:user).permit(:password,:password_confirmation)
  end

end
