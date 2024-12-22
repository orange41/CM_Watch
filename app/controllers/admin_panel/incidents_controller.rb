module AdminPanel
  class IncidentsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_incident, only: [:show, :edit, :update, :destroy, :approve, :reject]

    def index
      @incidents = if params[:approved] == 'true'
                     Incident.where(approved: true)
                   elsif params[:approved] == 'false'
                     Incident.where(approved: false)
                   else
                     Incident.all
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
      @incident.update(approved: true)
      redirect_to admin_panel_incidents_path, notice: '事故事例が承認されました。'
    end

    def reject
      @incident.destroy
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
