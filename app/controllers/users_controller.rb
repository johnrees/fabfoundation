class UsersController < ApplicationController

  authorize_actions_for User
  before_filter :require_new_user, only: [:new, :create]

  def complete_registration
    @user = User.where(action_token: params[:token]).first
  end
  authority_actions :complete_registration => 'create'

  def new
    @user = User.new
    render layout: 'sessions'
  end

  def index
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes user_params
      redirect_to user_url(@user), notice: "User Updated"
    else
      render :edit
    end
  end

  def register
    @user = User.find(params[:id])
    if @user.update_attributes user_params
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Registration complete!"
    else
      render :complete_registration
    end
  end
  authority_actions :register => 'create'

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path, notice: "Thanks for signing up. Please check your email to complete your registration."
    else
      render 'new', layout: 'sessions'
    end
  end

private

  def user_params
    params.require(:user).permit(
      :password,
      :email,
      :dob,
      :public_email,
      :public_phone,
      :url,
      :twitter_username,
      :first_name,
      :last_name,
      :bio,
      :avatar,
      :city,
      :country_code,
      :time_zone,
      referee_lab_ids: []
    )
  end

end
