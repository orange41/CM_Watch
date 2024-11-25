# app/controllers/admin_panel/comments_controller.rb
module AdminPanel
  class CommentsController < ApplicationController
    before_action :authenticate_admin!

    def index
      @comments = Comment.all
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
      @comment = Comment.find(params[:id])
    end

    def update
      @comment = Comment.find(params[:id])
      if @comment.update(comment_params)
        redirect_to admin_panel_comments_path, notice: 'コメントが更新されました。'
      else
        render :edit
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to admin_panel_comments_path, notice: 'コメントが削除されました。'
    end

    private

    def comment_params
      params.require(:comment).permit(:content, :incident_id, :user_id)
    end
  end
end
