class Staffs::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    build_resource(sign_up_params)
    Rails.logger.debug "Staff registration started: #{resource.inspect}"

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        sign_in(resource) # 新規登録後にサインインさせる
        Rails.logger.debug "Staff signed up successfully: #{resource.inspect}"
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        Rails.logger.debug "Staff signed up but not active: #{resource.inspect}"
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      Rails.logger.debug "Staff registration failed: #{resource.errors.full_messages}"
      respond_with resource
    end
  end

  protected

  def after_sign_up_path_for(resource)
    Rails.logger.debug "Redirecting after sign up to: #{staff_path(resource)}"
    staff_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:employee_number, :email, :name, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:employee_number, :email, :name, :password, :password_confirmation])
  end
end
