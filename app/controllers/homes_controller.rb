class HomesController < ApplicationController
  before_action :authenticate_user!, only: [:user_dashboard]
  before_action :authenticate_admin!, only: [:admin_dashboard]

  def index
    # トップページの表示
  end

  def user_login
    # ユーザーログインページの表示
    render 'user_login'
  end

  def admin_login
    # 管理者ログインページの表示
    render 'admin_login'
  end

  def user_dashboard
    # ユーザーダッシュボードの表示
  end

  def admin_dashboard
    # 管理者ダッシュボードの表示
  end

  private

  def authenticate_user!
    redirect_to new_user_session_path unless user_signed_in?
  end

  def authenticate_admin!
    redirect_to new_admin_session_path unless admin_signed_in?
  end
end
