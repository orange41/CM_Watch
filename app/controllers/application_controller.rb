# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_dashboard_path # 管理者用ダッシュボード
    elsif resource.is_a?(Staff)
      staff_dashboard_path # スタッフ用ダッシュボード
    else
      super
    end
  end
end
