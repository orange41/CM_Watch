module Staffs
  class IncidentsController < ApplicationController
    before_action :authenticate_staff!

    def index
      @incidents = current_staff.incidents
    end

    def show
      @incident = current_staff.incidents.find(params[:id])
    end

    def new
      @incident = current_staff.incidents.build
    end

    def create
      @incident = current_staff.incidents.build(incident_params)
      if @incident.save
        redirect_to staff_staff_incidents_path(current_staff), notice: '事故事例が作成されました。'
      else
        render :new
      end
    end

    def edit
      @incident = current_staff.incidents.find(params[:id])
    end

    def update
      @incident = current_staff.incidents.find(params[:id])
      if @incident.update(incident_params)
        redirect_to staff_staff_incident_path(current_staff, @incident), notice: '事故事例が更新されました。'
      else
        render :edit
      end
    end

    def destroy
      @incident = current_staff.incidents.find(params[:id])
      @incident.destroy
      redirect_to staff_staff_incidents_path(current_staff), notice: '事故事例が削除されました。'
    end

    private

    def incident_params
      params.require(:incident).permit(:title, :description, :occurred_at)
    end
  end
end
