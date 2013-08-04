class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def not_authenticated
    redirect_to signin_url, :alert => "Oops. You'll need to sign in to do that."
  end

private

  def true_current_user
    if current_user
      current_user
    else
      User.new
    end
  end
  helper_method :true_current_user

end
