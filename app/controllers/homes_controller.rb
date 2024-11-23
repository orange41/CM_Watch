class HomesController < ApplicationController
  def index
    # トップページの表示
  end

  def user_login
    # 必要なロジックをここに追加
    render 'user_login'
     # これにより、user_login.html.erb テンプレートをレンダリング
  end

  def admin_login
    # 管理者ログインページの表示
  end

  def user_dashboard
    # ユーザーダッシュボードの表示
  end
end
