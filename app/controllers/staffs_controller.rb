# app/controllers/staffs_controller.rb
class StaffsController < ApplicationController
  before_action :authenticate_staff!, only: [:show, :edit, :update]

  def show
    @staff = current_staff
    render 'staffs/show'
  end

  def edit
    @staff = current_staff
  end

  def update
    @staff = current_staff
    if @staff.update(staff_params)
      redirect_to staff_dashboard_path, notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  private

  def staff_params
    params.require(:staff).permit(:password, :password_confirmation)
  end
end
