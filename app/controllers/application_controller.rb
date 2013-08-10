class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def not_authenticated
    redirect_to signin_url, :alert => "Oops. You'll need to sign in to do that."
  end

  def require_login
    if current_user.nil?
      redirect_to signin_url, :alert => "You must first sign in to access this page"
    end
  end

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authority_user
    current_user || User.new
  end

  def body_classes
    "c-#{controller_name} a-#{action_name}"
  end

  helper_method :authority_user
  helper_method :current_user
  helper_method :body_classes

end
