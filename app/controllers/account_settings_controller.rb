class AccountSettingsController < ApplicationController
  before_action :require_login

  def show; end

  def edit; end

  def update
    if changing_password? && !current_user.authenticate(params[:user][:current_password])
      current_user.errors.add(:current_password, "no coincide")
      render :edit, status: :unprocessable_entity
      return
    end

    if current_user.update(account_params)
      current_user.rotate_session_token! if changing_password?
      session[:session_token] = current_user.session_token
      redirect_to account_settings_path, notice: "Cuenta actualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def changing_password?
    params.dig(:user, :password).present?
  end

  def account_params
    permitted = params.require(:user).permit(:name, :email, :rfc, :password, :password_confirmation)
    permitted.delete(:password) if permitted[:password].blank?
    permitted.delete(:password_confirmation) if permitted[:password_confirmation].blank?
    permitted
  end
end
