class AdminPanel::NotificationsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @notifications = Notification.all
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    if @notification.update(read: true)
      redirect_to admin_panel_notifications_path, notice: '通知が既読になりました。'
    else
      redirect_to admin_panel_notifications_path, alert: '通知を既読にできませんでした。'
    end
  end
end
