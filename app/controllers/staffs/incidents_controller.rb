module Staffs
  class IncidentsController < ApplicationController
    before_action :authenticate_staff!
    before_action :set_incident, only: [:show, :edit, :update, :destroy]

    def index
      @incidents = current_staff.incidents
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
      @incident.staff = current_staff # 投稿者を設定
      if @incident.save
        redirect_to staffs_incidents_path, notice: '事故事例が作成されました。'
      else
        render :new
      end
    end

    def show
      @comment = @incident.comments.build
    end

    def edit
      # 編集用アクション
    end

    def update
      if @incident.update(incident_params)
        redirect_to staffs_incidents_path, notice: '事故事例が更新されました。'
      else
        render :edit
      end
    end

    def destroy
      @incident.destroy
      redirect_to staffs_incidents_path, notice: '事故事例が削除されました。'
    end

    private

    def set_incident
      @incident = current_staff.incidents.find(params[:id])
    end

    def incident_params
      params.require(:incident).permit(:title, :description, :occurred_at, :category_id)
    end
  end
end
