module AdminPanel
  class IncidentsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_incident, only: [:show, :edit, :update, :destroy, :approve, :reject]

    def index
      @incidents = if params[:approved] == 'true'
                     Incident.includes(:category, :staff).where(approved: true)
                   elsif params[:approved] == 'false'
                     Incident.includes(:category, :staff).where(approved: false)
                   else
                     Incident.includes(:category, :staff).all
                   end

      if params[:sort].present? && params[:direction].present?
        case params[:sort]
        when 'title'
          @incidents = @incidents.order("title #{params[:direction]}")
        when 'occurred_at'
          @incidents = @incidents.order("occurred_at #{params[:direction]}")
        when 'category'
          @incidents = @incidents.joins(:category).order("categories.title #{params[:direction]}")
        when 'staff'
          @incidents = @incidents.joins(:staff).order("staffs.name #{params[:direction]}")
        when 'approved'
          @incidents = @incidents.order("approved #{params[:direction]}")
        else
          Rails.logger.info "Invalid sort parameter: #{params[:sort]}"
        end
      end
    end

    def show
    end

    def new
      @incident = Incident.new
    end

    def create
      @incident = Incident.new(incident_params)
      if @incident.save
        redirect_to admin_panel_incidents_path, notice: '事故事例が作成されました。'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @incident.update(incident_params)
        redirect_to admin_panel_incidents_path, notice: '事故事例が更新されました。'
      else
        render :edit
      end
    end

    def destroy
      @incident.destroy
      redirect_to admin_panel_incidents_path, notice: '事故事例が削除されました。'
    end

    def approve
      if @incident.update(approved: true)
        notification = Notification.new(
          notifiable: @incident.staff,
          message: "あなたの事故事例が承認されました。タイトル: #{@incident.title}",
          read: false
        )
        if notification.save
          puts "Notification created for #{@incident.staff.email}"
        else
          puts "Failed to create notification: #{notification.errors.full_messages.join(", ")}"
        end

        redirect_to admin_panel_incidents_path, notice: '事故事例が承認されました。'
      else
        redirect_to admin_panel_incidents_path, alert: '事故事例の承認に失敗しました。'
      end
    end

    def reject
      @incident.destroy
      # 非承認時に通知を送信
      notification = Notification.new(
        notifiable: @incident.staff,
        message: "あなたの事故事例が非承認されました。タイトル: #{@incident.title}",
        read: false
      )
      if notification.save
        puts "Notification created for #{@incident.staff.email}"
      else
        puts "Failed to create notification: #{notification.errors.full_messages.join(", ")}"
      end

      redirect_to admin_panel_incidents_path, alert: '事故事例が非承認され削除されました。'
    end

    private

    def set_incident
      @incident = Incident.find(params[:id])
    end

    def incident_params
      params.require(:incident).permit(:title, :description, :occurred_at, :category_id, :approved)
    end
  end
end
