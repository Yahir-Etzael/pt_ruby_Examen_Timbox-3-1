class ManagedUsersController < ApplicationController
  before_action :require_login
  before_action :set_managed_user, only: %i[show edit update destroy]

  def index
    @managed_users = current_user.managed_users.order(created_at: :desc)
  end

  def show; end

  def new
    @managed_user = current_user.managed_users.new
  end

  def create
    @managed_user = current_user.managed_users.new(managed_user_params)
    @managed_user.created_by = current_user

    if @managed_user.save
      redirect_to @managed_user, notice: "Usuario asociado creado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @managed_user.update(managed_user_params)
      redirect_to @managed_user, notice: "Usuario asociado actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @managed_user.destroy
    redirect_to managed_users_path, notice: "Usuario asociado eliminado."
  end

  private

  def set_managed_user
    @managed_user = current_user.managed_users.find(params[:id])
  end

  def managed_user_params
    params.require(:managed_user).permit(:name, :rfc, :address, :phone, :website)
  end
end
