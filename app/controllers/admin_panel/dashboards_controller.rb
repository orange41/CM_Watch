module AdminPanel
  class DashboardsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_admin, only: [:show, :edit, :update]

    def show
      @admin = current_admin
      # デバッグ用のコードはコメントアウトまたは削除
      # logger.debug "current_admin: #{@admin.inspect}"
      if @admin.nil?
        redirect_to new_admin_session_path, alert: '管理者情報が見つかりません。もう一度ログインしてください。'
      end
    end

    def edit
      @admin = current_admin
      # デバッグ用のコードはコメントアウトまたは削除
      # logger.debug "Editing admin: #{@admin.inspect}"
    end

    def update
      @admin = current_admin
      if @admin.update(admin_params)
        bypass_sign_in(@admin) # パスワード更新後にセッションを再設定
        # デバッグ用のコードはコメントアウトまたは削除
        # logger.debug "Updated admin: #{@admin.inspect}"
        redirect_to admin_dashboard_path(@admin), notice: 'プロフィールが更新されました。'
      else
        # デバッグ用のコードはコメントアウトまたは削除
        # logger.debug "Update failed: #{@admin.errors.full_messages.join(", ")}"
        render :edit
      end
    end

    private

    def set_admin
      @admin = Admin.find(params[:id])
    end

    def admin_params
      params.require(:admin).permit(:employee_number, :password, :password_confirmation).tap do |admin_params|
        if admin_params[:password].blank?
          admin_params.delete(:password)
          admin_params.delete(:password_confirmation)
        end
      end
    end
  end
end
