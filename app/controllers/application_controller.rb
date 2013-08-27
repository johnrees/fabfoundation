class ApplicationController < ActionController::Base

  # around_filter :user_time_zone, if: :current_user

  # CanCan workaround
  # See: https://github.com/ryanb/cancan/issues/835#issuecomment-18663815
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  protect_from_forgery with: :exception
  def not_authenticated
    redirect_to signin_url, :alert => "Oops. You'll need to sign in to do that."
  end

  def require_login
    if current_user.nil?
      redirect_to signin_url(goto: request.path), :alert => "You must first sign in to access this page"
    end
  end

  def require_new_user
    if current_user
      redirect_to root_url, :alert => "You must sign out of your current session first"
    end
  end

private

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil
    end
  end


  def body_classes
    "c-#{controller_name} a-#{action_name}"
  end

  # def user_time_zone(&block)
  #   Time.use_zone(current_user.time_zone, &block)
  # end

  helper_method :current_user
  helper_method :body_classes

end
