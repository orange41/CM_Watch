class StaffsController < ApplicationController
  before_action :authenticate_staff!
  before_action :set_staff, only: [:show, :edit, :update]

  def show
    @staff = current_staff
    # デバッグ用のコードはコメントアウトまたは削除
     logger.debug "current_staff: #{@staff.inspect}"
    if @staff.nil?
      redirect_to new_staff_session_path, alert: 'スタッフ情報が見つかりません。もう一度ログインしてください。'
    end
  end

  def edit
    @staff = current_staff
    # デバッグ用のコードはコメントアウトまたは削除
     logger.debug "Editing staff: #{@staff.inspect}"
  end

  def update
    @staff = current_staff
    if @staff.update(staff_params)
      bypass_sign_in(@staff) # パスワード更新後にセッションを再設定
      # デバッグ用のコードはコメントアウトまたは削除
       logger.debug "Updated staff: #{@staff.inspect}"
      redirect_to @staff, notice: 'プロフィールが更新されました。'
    else
      # デバッグ用のコードはコメントアウトまたは削除
       logger.debug "Update failed: #{@staff.errors.full_messages.join(", ")}"
      render :edit
    end
  end

  private

  def set_staff
    @staff = Staff.find(params[:id])
  end

  def staff_params
    params.require(:staff).permit(:name, :password, :password_confirmation).tap do |staff_params|
      if staff_params[:password].blank?
        staff_params.delete(:password)
        staff_params.delete(:password_confirmation)
      end
    end
  end
end
