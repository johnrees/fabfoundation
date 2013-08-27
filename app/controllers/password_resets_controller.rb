class PasswordResetsController < ApplicationController

  before_filter :require_new_user

  def create
    user = User.find_by(email: params[:email])
    user.send_password_reset if user
    redirect_to root_url, notice: "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by!(forgot_password_token: params[:id])
  end

  def update
    @user = User.find_by!(forgot_password_token: params[:id])
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
