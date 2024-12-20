class CommentsController < ApplicationController
  before_action :set_incident

  def create
    @comment = @incident.comments.build(comment_params)
    @comment.staff = current_staff
    @comment.approved = false

    if @comment.save
      redirect_to staffs_incident_path(@incident), notice: 'コメントが作成されました。管理者の承認を待っています。'
    else
      render :new
    end
  end

  private

  def set_incident
    @incident = Incident.find(params[:incident_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
