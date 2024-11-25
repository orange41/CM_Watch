# app/controllers/admin_panel/incidents_controller.rb
module AdminPanel
  class IncidentsController < ApplicationController
    before_action :authenticate_admin!

    def index
      @incidents = Incident.all
    end

    def new
      @incident = Incident.new
    end

    def create
      @incident = Incident.new(incident_params)
      if @incident.save
        redirect_to admin_panel_incidents_path, notice: '新しい事故事例が投稿されました。'
      else
        render :new
      end
    end

    def edit
      @incident = Incident.find(params[:id])
    end

    def update
      @incident = Incident.find(params[:id])
      if @incident.update(incident_params)
        redirect_to admin_panel_incidents_path, notice: '事故事例が更新されました。'
      else
        render :edit
      end
    end

    def destroy
      @incident = Incident.find(params[:id])
      @incident.destroy
      redirect_to admin_panel_incidents_path, notice: '事故事例が削除されました。'
    end

    private

    def incident_params
      params.require(:incident).permit(:title, :description, :user_id)
    end
  end
end
