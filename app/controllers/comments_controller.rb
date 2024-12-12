class CommentsController < ApplicationController
  before_action :authenticate_staff!

  def create
    @incident = Incident.find(params[:incident_id])
    @comment = @incident.comments.build(comment_params)
    @comment.staff = current_staff
    if @comment.save
      redirect_to staff_incident_path(current_staff, @incident), notice: 'コメントが投稿されました。'
    else
      render 'incidents/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
