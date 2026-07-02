class DashboardController < ApplicationController
  before_action :require_login

  def index
    @collaborators_count = current_user.collaborators.count
    @managed_users_count = current_user.managed_users.count
  end
end
