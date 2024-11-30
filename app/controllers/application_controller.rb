class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_panel_admin_dashboard_path
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
