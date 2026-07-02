class CollaboratorsController < ApplicationController
  before_action :require_login
  before_action :set_collaborator, only: %i[show edit update destroy]

  def index
    @collaborators = current_user.collaborators.order(created_at: :desc)
  end

  def show; end

  def new
    @collaborator = current_user.collaborators.new
  end

  def create
    @collaborator = current_user.collaborators.new(collaborator_params)

    if @collaborator.save
      redirect_to @collaborator, notice: "Colaborador creado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @collaborator.update(collaborator_params)
      redirect_to @collaborator, notice: "Colaborador actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @collaborator.destroy
    redirect_to collaborators_path, notice: "Colaborador eliminado."
  end

  private

  def set_collaborator
    @collaborator = current_user.collaborators.find(params[:id])
  end

  def collaborator_params
    params.require(:collaborator).permit(:name, :email, :rfc, :fiscal_address, :curp, :nss,
                                         :start_date, :contract_type, :department, :position,
                                         :daily_salary, :salary, :entity_key, :state)
  end
end
