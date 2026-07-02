class RegistrationsController < ApplicationController
  before_action :redirect_if_logged_in

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.rotate_session_token!
      session[:user_id] = @user.id
      session[:session_token] = @user.session_token
      redirect_to root_path, notice: "Registro completado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :rfc, :password, :password_confirmation)
  end
end
