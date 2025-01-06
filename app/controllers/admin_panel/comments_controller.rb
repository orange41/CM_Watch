class AdminPanel::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.all.joins(:incident).order("#{sort_column} #{sort_direction}")
  end

  def approve
    puts "Approve action called for comment #{params[:id]}"

    @comment = Comment.find(params[:id])

    if @comment.update(approved: true)
      puts "Comment approved: #{@comment.id}"

      begin
        staff = @comment.staff
        puts "Staff: #{staff.email}" # デバッグメッセージ
        incident = @comment.incident
        puts "Incident: #{incident.title}" # デバッグメッセージ

        # スタッフに通知
        notification = Notification.new(
          notifiable: staff,
          message: "あなたのコメントが承認されました。事故事例: #{incident.title}, コメント内容: #{@comment.content}",
          read: false
        )
        if notification.save
          puts "Notification created for #{staff.email}"
        else
          puts "Failed to create notification: #{notification.errors.full_messages.join(", ")}"
        end
      rescue => e
        puts "Exception encountered while creating notification: #{e.message}"
      end

    else
      puts "Failed to approve comment: #{@comment.errors.full_messages.join(", ")}"
    end

    redirect_to admin_panel_comments_path, notice: 'コメントが承認されました。'
  end

  def reject
    puts "Reject action called for comment #{params[:id]}"

    @comment = Comment.find(params[:id])

    if @comment.destroy
      puts "Comment rejected and deleted: #{@comment.id}"

      begin
        staff = @comment.staff
        puts "Staff: #{staff.email}" 
        incident = @comment.incident
        puts "Incident: #{incident.title}" 

        # スタッフに通知
        notification = Notification.new(
          notifiable: staff,
          message: "あなたのコメントが非承認されました。事故事例: #{incident.title}, コメント内容: #{@comment.content}",
          read: false
        )
        if notification.save
          puts "Notification created for #{staff.email}"
        else
          puts "Failed to create notification: #{notification.errors.full_messages.join(", ")}"
        end
      rescue => e
        puts "Exception encountered while creating notification: #{e.message}"
      end

    else
      puts "Failed to reject comment: #{@comment.errors.full_messages.join(", ")}"
    end

    redirect_to admin_panel_comments_path, alert: 'コメントが非承認されました。'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def sort_column
    if params[:sort] == 'incident'
      'incidents.title'
    else
      %w[content approved].include?(params[:sort]) ? params[:sort] : 'content'
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
