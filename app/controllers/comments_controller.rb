class CommentsController < ApplicationController
  before_action :authenticate_staff!
  before_action :set_incident, only: [:create, :approve]

  def create
    @comment = @incident.comments.build(comment_params)
    @comment.staff = current_staff
    @comment.approved = false

    if @comment.save
      # 管理者に通知を送信
      Admin.find_each do |admin|
        notification = Notification.new(
          notifiable: admin,
          message: "新しいコメントの承認をお願いします。事故事例: #{@incident.title}, コメント内容: #{@comment.content}",
          read: false
        )
        if notification.save
          puts "Notification created for #{admin.email}"
        else
          puts notification.errors.full_messages
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

    # スタッフに通知を送信
    notification = Notification.new(
      notifiable: @comment.staff,
      message: "あなたのコメントが承認されました。事故事例: #{@comment.incident.title}, コメント内容: #{@comment.content}",
      read: false
    )
    if notification.save
      puts "Notification created for #{@comment.staff.email}"
    else
      puts notification.errors.full_messages
    end

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
