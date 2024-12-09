class Admins::RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :employee_number)
  end

  def account_update_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :current_password, :employee_number)
  end
end
