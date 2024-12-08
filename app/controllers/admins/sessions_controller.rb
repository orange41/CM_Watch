# app/controllers/admins/sessions_controller.rb
class Admins::SessionsController < Devise::SessionsController
  # Adminのログイン処理
  def create
    Rails.logger.info "Admin ログイン試行: #{params[:admin][:employee_number]}"
    super
  end
end
