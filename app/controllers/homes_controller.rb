class HomesController < ApplicationController
  before_action :authenticate_staff!, only: [:user_dashboard]
  before_action :authenticate_admin!, only: [:admin_dashboard]
  
  def index
    # トップページ
  end

  def about
    # Aboutページ
  end

  def user_dashboard
    @staff = current_staff
    @notifications = current_staff.notifications.order(created_at: :desc).limit(5)
    render 'staffs/show'
  end

  def admin_dashboard
    @admin = current_admin
    render 'admin_panel/dashboards/show'
  end
end
