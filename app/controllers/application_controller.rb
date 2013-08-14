class ApplicationController < ActionController::Base

  around_filter :user_time_zone, if: :current_user

  protect_from_forgery with: :exception
  def not_authenticated
    redirect_to signin_url, :alert => "Oops. You'll need to sign in to do that."
  end

  def require_login
    if current_user.nil?
      redirect_to signin_url(goto: request.path), :alert => "You must first sign in to access this page"
    end
  end

private

  def current_user
    # session[:user_id] = nil
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authority_user
    current_user || User.new
  end

  def body_classes
    "c-#{controller_name} a-#{action_name}"
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  helper_method :authority_user
  helper_method :current_user
  helper_method :body_classes

end
