# app/controllers/admin_panel/staffs_controller.rb
module AdminPanel
  class StaffsController < ApplicationController
    before_action :authenticate_admin!

    def index
      @staffs = Staff.all
    end

    def new
      @staff = Staff.new
    end

    def create
      @staff = Staff.new(staff_params)
      if @staff.save
        redirect_to admin_panel_staffs_path, notice: '新しい社員が登録されました。'
      else
        render :new
      end
    end

    def edit
      @staff = Staff.find(params[:id])
    end

    def update
      @staff = Staff.find(params[:id])
      if @staff.update(staff_params)
        redirect_to admin_panel_staffs_path, notice: '社員情報が更新されました。'
      else
        render :edit
      end
    end

    def destroy
      @staff = Staff.find(params[:id])
      @staff.destroy
      redirect_to admin_panel_staffs_path, notice: '社員が削除されました。'
    end

    private

    def staff_params
      params.require(:staff).permit(:employee_number, :name)
    end
  end
end
