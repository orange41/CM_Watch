class Staffs::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  protected

  def after_sign_in_path_for(resource)
    staffs_dashboard_path # ダッシュボードにリダイレクト
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:employee_number, :password])
  end
end
