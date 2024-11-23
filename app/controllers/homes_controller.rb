# app/controllers/homes_controller.rb
class HomesController < ApplicationController
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
end
