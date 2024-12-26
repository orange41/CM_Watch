module AdminPanel
  class NotificationsController < ApplicationController
    before_action :authenticate_admin!

    def index
      @notifications = current_admin.notifications.unread
    end

    def mark_as_read
      @notification = Notification.find(params[:id])
      @notification.update(read: true)
      redirect_to admin_panel_notifications_path
    end
  end
end
