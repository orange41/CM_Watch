class NotificationsController < ApplicationController
  def index
    if admin_signed_in?
      @notifications = current_admin.notifications.unread
    elsif staff_signed_in?
      @notifications = current_staff.notifications.unread
    else
      @notifications = [] 
    end
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    @notification.update(read: true)
    redirect_to notifications_path
  end
end
