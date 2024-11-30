class HomesController < ApplicationController
  before_action :authenticate_staff!, only: [:user_dashboard]
  before_action :authenticate_admin!, only: [:admin_dashboard]

  def index
    # トップページの表示
  end

  def user_dashboard
    # ユーザーダッシュボードの表示
  end

  def admin_dashboard
    # 管理者ダッシュボードの表示
  end
end
