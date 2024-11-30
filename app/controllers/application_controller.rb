class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:employee_number, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:employee_number, :name, :password, :password_confirmation, :current_password])
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_panel_admin_dashboard_path # 適切なパスに修正
    elsif resource.is_a?(Staff)
      staff_path(resource)
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
