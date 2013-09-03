class UsersController < ApplicationController

  # before_filter :require_new_user, only: [:new, :create]

  def complete_registration
    begin
      @user = User.find_by!(invite_token: params[:token])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url, notice: "Not found"
    end
  end
  # authority_actions :complete_registration => 'create'

  def change_password
    @user = current_user
    authorize! :edit, @user
  end

  def update_password
    @user = current_user
    if @user.authenticate(params[:user][:current_password])
      if @user.update_attributes(user_params)
        redirect_to edit_user_url(@user), notice: "Password updated"
      else
        render :change_password
      end
    else
      render :change_password, notice: "Incorrect current password"
    end
  end

  def new
    @user = User.new
    render layout: 'sessions'
    authorize! :new, @user
  end

  def index
    @users = User.all
  end

  def edit
    @user = current_user
    authorize! :edit, @user
  end

  def update
    @user = current_user
    if @user.update_attributes user_params
      redirect_to root_url, notice: "Settings Updated"
    else
      render :edit
    end
  end

  def register
    @user = User.find(params[:id])
    if @user.update_attributes user_params
      @user.confirm! if @user.can_confirm?
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Registration complete!"
    else
      render :complete_registration
    end
  end
  # authority_actions :register => 'create'

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.invite! if @user.can_invite?
      redirect_to root_path, notice: "Thanks for signing up. Please check your email to complete your registration."
    else
      render 'new', layout: 'sessions'
    end
  end

private

  def user_params
    params.require(:user).permit(
      :password,
      :current_password,
      :password_confirmation,
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
