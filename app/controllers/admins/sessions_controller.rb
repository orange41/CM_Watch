class Admins::SessionsController < Devise::SessionsController
  def new
    Rails.logger.info "Params in new action: #{params.inspect}"
    super
  end

  def create
    Rails.logger.info "Params in create action: #{params.inspect}"
    admin_params = sign_in_params
    Rails.logger.info "Admin Params: #{admin_params.inspect}"
    super
  end

  private

  def sign_in_params
    Rails.logger.info "Calling sign_in_params"
    if params[:admin].present?
      params.require(:admin).permit(:employee_number, :password)
    else
      {}
    end
  end
end
