class Admins::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      unless resource.persisted?
        flash.now[:alert] = '必要事項を記入してください。'
        respond_with resource, location: new_admin_registration_path and return
      end
    end
  end

  private

  def sign_up_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :employee_number)
  end

  def account_update_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :current_password, :employee_number)
  end
end
