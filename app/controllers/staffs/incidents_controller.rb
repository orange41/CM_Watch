module Staffs
  class IncidentsController < ApplicationController
    before_action :authenticate_staff!
    before_action :set_incident, only: [:show, :edit, :update, :destroy]

    def index
      @incidents = current_staff.incidents
    end

    def new
      @incident = current_staff.incidents.build
    end

    def create
      @incident = current_staff.incidents.build(incident_params)
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
