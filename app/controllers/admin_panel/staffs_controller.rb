class AdminPanel::StaffsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_staff, only: [:destroy]

  def index
    @staffs = Staff.all.order("#{sort_column} #{sort_direction}")
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_params)

    if @staff.save
      redirect_to admin_panel_staffs_path, notice: 'スタッフが正常に作成されました。初回ログイン時にパスワードを設定してください。'
    else
      flash.now[:alert] = @staff.errors.full_messages.join(', ')
      render :new
    end
  end

  def destroy
    @staff.destroy
    redirect_to admin_panel_staffs_path, notice: 'スタッフが正常に削除されました。'
  end

  private

  def set_staff
    @staff = Staff.find(params[:id])
  end

  def staff_params
    params.require(:staff).permit(:employee_number, :name, :email, :password, :password_confirmation)
  end

  def sort_column
    %w[employee_number name].include?(params[:sort]) ? params[:sort] : 'employee_number'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
