class PasswordsController < ApplicationController
  before_action :redirect_if_logged_in

  def new; end

  def create
    @user = User.find_by(email: params[:email].to_s.strip.downcase, rfc: params[:rfc].to_s.strip.upcase)

    if @user&.update(password: params[:password], password_confirmation: params[:password_confirmation])
      @user.rotate_session_token!
      redirect_to login_path, notice: "Password actualizado. Inicia sesion nuevamente."
    else
      flash.now[:alert] = "No se pudo actualizar. Verifica correo, RFC y confirmacion de password."
      render :new, status: :unprocessable_entity
    end
  end
end
