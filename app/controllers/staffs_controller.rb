class StaffsController < ApplicationController
  before_action :authenticate_staff!, except: [:index]
  before_action :authenticate_admin!, only: [:index]
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  def index
    @staffs = Staff.all
  end

  def show
    @notifications = Notification.where(staff_id: @staff.id).order(created_at: :desc)  # 通知用
  end

  def edit
  end

  def update
    if @staff.update(staff_params)
      bypass_sign_in(@staff)
      redirect_to @staff, notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  private

  def set_staff
    @staff = current_staff
  end

  def staff_params
    params.require(:staff).permit(:employee_number, :name, :password, :password_confirmation).tap do |staff_params|
      if staff_params[:password].blank?
        staff_params.delete(:password)
        staff_params.delete(:password_confirmation)
      end
    end
  end
end
