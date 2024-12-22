class StaffsController < ApplicationController
  before_action :authenticate_staff!, except: [:index]
  before_action :authenticate_admin!, only: [:index] # 管理者がアクセスできるようにする

  def index
    @staffs = Staff.all
  end

  def show
    @staff = Staff.find(params[:id])
  end

  def edit
    @staff = current_staff
  end

  def update
    @staff = current_staff
    if @staff.update(staff_params)
      bypass_sign_in(@staff) # パスワード更新後にセッションを再設定
      redirect_to @staff, notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  private

  def staff_params
    params.require(:staff).permit(:employee_number, :name, :password, :password_confirmation).tap do |staff_params|
      if staff_params[:password].blank?
        staff_params.delete(:password)
        staff_params.delete(:password_confirmation)
      end
    end
  end
end
