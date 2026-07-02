class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = User.find_by(id: session[:user_id], session_token: session[:session_token])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    return if logged_in?

    redirect_to login_path, alert: "Inicia sesion para continuar."
  end

  def redirect_if_logged_in
    redirect_to root_path if logged_in?
  end
end
