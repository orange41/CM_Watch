class CommentsController < ApplicationController
  before_action :authenticate_staff!
  before_action :set_incident

  def create
    @comment = @incident.comments.build(comment_params)
    @comment.staff = current_staff
    @comment.approved = false

    if @comment.save
      # 管理者に通知を送信
      Admin.find_each do |admin|
        Notification.create(
          notifiable: admin,
          message: '新しいコメントの承認をお願いします。'
        end
      end

      redirect_to staffs_incident_path(@incident), notice: 'コメントが作成されました。管理者の承認を待っています。'
    else
      render :new
    end
  end

  def approve
    @comment = Comment.find(params[:id])
    @comment.update(approved: true)

    Notification.create(
      notifiable: @comment.staff,
      message: 'あなたのコメントが承認されました。掲示板に表示されています。'
    )

    redirect_to staffs_incident_path(@comment.incident), notice: 'コメントが承認されました'
  end

  private

  def set_incident
    @incident = Incident.find(params[:incident_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
