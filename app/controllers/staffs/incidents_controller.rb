module Staffs
  class IncidentsController < ApplicationController
    before_action :authenticate_staff!
    before_action :set_incident, only: [:show, :edit, :update, :destroy, :approve]

    def index
      @incidents = Incident.where(approved: true)
      @incidents = @incidents.joins(:category).where('incidents.title LIKE ? OR incidents.description LIKE ? OR categories.title LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?

      if params[:sort].present?
        case params[:sort]
        when 'title'
          @incidents = @incidents.order(title: params[:direction])
        when 'description'
          @incidents = @incidents.order(description: params[:direction])
        when 'category'
          @incidents = @incidents.joins(:category).order("categories.title #{params[:direction]}")
        when 'staff'
          @incidents = @incidents.joins(:staff).order("staffs.name #{params[:direction]}")
        end
      end
    end

    def new
      @incident = current_staff.incidents.build
    end

    def create
      @incident = current_staff.incidents.build(incident_params)
      @incident.approved = false # 承認フラグの初期値を設定

      @incident.updates.each do |update|
        if update.description.blank?
          update.destroy
        end
      end

      if @incident.save
        # 管理者に通知を送信
        Admin.find_each do |admin|
          Notification.create(
            notifiable: admin,
            message: '新しい事故事例の承認をお願いします。'
          )
        end

        redirect_to staffs_incidents_path, notice: '事故事例が作成され、管理者の承認を待っています。'
      else
        Rails.logger.error @incident.errors.full_messages.join(", ") # エラーメッセージをログに出力
        render :new
      end
    end

    def show
      @incident = Incident.find(params[:id])
      @comments = @incident.comments.where(approved: true) # 承認済みのコメントのみを取得
      @comment = @incident.comments.build
    
      # 元記事とすべての更新分を取得
      @original_incident = @incident.original_incident || @incident
      @updates = @original_incident.updates.where(approved: true) # 承認済みの更新分のみを取得
      Rails.logger.debug "Original Incident: #{@original_incident.inspect}"
      Rails.logger.debug "Updates: #{@updates.inspect}"
    end
    

    def edit
    end

    def update
      Rails.logger.debug "Update Params: #{incident_params.inspect}"  # デバッグ用ログ
    
      if incident_params[:updates_attributes].present?
        incident_params[:updates_attributes].each do |index, update_params|
          update_params[:staff_id] = current_staff.id
          update_params[:approved] = false  # デフォルトの承認フラグを設定
          Rails.logger.debug "Update Params after setting staff_id and approved: #{update_params.inspect}"
        end
      end
    
      @incident.assign_attributes(incident_params)
      Rails.logger.debug "Incident after assign_attributes: #{@incident.inspect}"
    
      @incident.updates.each do |update|
        if update.description.blank?
          update.destroy
        else
          update.staff_id ||= current_staff.id
          update.approved ||= false
          update.original_incident_id = @incident.id
          Rails.logger.debug "Update after manual assignment: #{update.inspect}"
        end
      end
    
      if @incident.save
        # 管理者に通知を送信
        Admin.find_each do |admin|
          Notification.create(
            notifiable: admin,
            message: '新しい事故事例の更新があり、承認が必要です。'
          )
        end

        redirect_to staffs_incident_path(@incident), notice: '事故事例が更新され、管理者の承認を待っています。'
      else
        Rails.logger.error "Incident errors: #{@incident.errors.full_messages.join(", ")}"
        @incident.updates.each { |update| Rails.logger.error "Update errors: #{update.errors.full_messages.join(", ")}" }
        render :edit
      end
    end

    def destroy
      @incident.destroy
      redirect_to staffs_incidents_path, notice: '事故事例が削除されました。'
    end

    def approve
      @incident.update(approved: true)

      @incident.updates.each do |update|
        update.update(approved: true)
      end

      # スタッフに通知を送信
      Notification.create(
        notifiable: @incident.staff,
        message: 'あなたの事故事例が承認されました。掲示板に表示されています。'
      )

      redirect_to staffs_incidents_path, notice: '事故事例が承認されました。'
    end

    private

    def set_incident
      @incident = Incident.find(params[:id])
    end

    def incident_params
      params.require(:incident).permit(
        :title, :description, :occurred_at, :category_id,
        updates_attributes: [:id, :title, :description, :occurred_at, :staff_id, :approved]
      )
    end
  end
end
