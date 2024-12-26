module AdminPanel
  class DashboardsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_admin, only: [:show, :edit, :update]



    def show
      @admin = current_admin
      @notifications = current_admin.notifications.order(created_at: :desc).limit(5)
    end

    def edit
      @admin = current_admin
    end

    def update
      @admin = current_admin
      if @admin.update(admin_params)
        redirect_to admin_panel_admin_dashboard_path, notice: 'プロフィールが更新されました。'
      else
        flash.now[:alert] = @admin.errors.full_messages.join(', ') # バリデーションエラーをフラッシュメッセージで表示
        render :edit
      end
    end

    private

    def set_admin
      @admin = current_admin
    end

    def admin_params
      params.require(:admin).permit(:employee_number, :name, :password, :password_confirmation).tap do |admin_params|
        if admin_params[:password].blank?
          admin_params.delete(:password)
          admin_params.delete(:password_confirmation)
        end
      end
    end
  end
end
