class Backstage::UsersController < Backstage::BackstageController

  def show
  end

  def index
    @q = User.search params[:q]
    @users = @q.result(distinct: true).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes user_params
      redirect_to backstage_users_url, notice: "User Updated"
    else
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit!
    # (
    #   :first_name, :last_name, :admin,
    #   :email, :public_email, :phone, :public_phone,
    #   :location, :country_code,
    #   :latitude, :longitude, :url, :bio,
    #   :avatar, :locale, :timezone)
  end

end
