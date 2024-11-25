# app/controllers/incidents_controller.rb
class IncidentsController < ApplicationController
  before_action :authenticate_staff!

  def index
    @incidents = Incident.all
  end

  def new
    @incident = Incident.new
  end

  def create
    @incident = Incident.new(incident_params)
    @incident.staff = current_staff
    if @incident.save
      redirect_to staff_incidents_path(current_staff), notice: '事故事例が投稿されました。'
    else
      render :new
    end
  end

  def show
    @incident = Incident.find(params[:id])
    @comments = @incident.comments
    @comment = Comment.new
  end

  private

  def incident_params
    params.require(:incident).permit(:title, :description)
  end
end
