class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]

  def new; end

  def create
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    if user&.authenticate(params[:password])
      user.rotate_session_token!
      session[:user_id] = user.id
      session[:session_token] = user.session_token
      redirect_to root_path, notice: "Bienvenido, #{user.name}."
    else
      flash.now[:alert] = "Los valores introducidos no coinciden con los registros en el sistema."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    current_user&.rotate_session_token!
    reset_session
    redirect_to login_path, notice: "Sesion cerrada correctamente."
  end
end
