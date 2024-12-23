module AdminPanel
  class CommentsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_comment, only: [:edit, :update, :destroy, :approve, :reject]

    def index
      @comments = if params[:approved] == 'true'
                    Comment.where(approved: true)
                  elsif params[:approved] == 'false'
                    Comment.where(approved: false)
                  else
                    Comment.all
                  end
    end

    def new
      @comment = Comment.new
    end

    def create
      @comment = Comment.new(comment_params)
      if @comment.save
        redirect_to admin_panel_comments_path, notice: '新しいコメントが投稿されました。'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @comment.update(comment_params)
        redirect_to admin_panel_comments_path, notice: 'コメントが更新されました。'
      else
        render :edit
      end
    end

    def destroy
      @comment.destroy
      redirect_to admin_panel_comments_path, notice: 'コメントが削除されました。'
    end

    def approve
      @comment.update(approved: true)
      redirect_to admin_panel_comments_path, notice: 'コメントが承認されました。'
    end

    def reject
      @comment.update(approved: false)
      redirect_to admin_panel_comments_path, alert: 'コメントが非承認されました。'
    end

    private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :incident_id, :staff_id)
    end
  end
end
