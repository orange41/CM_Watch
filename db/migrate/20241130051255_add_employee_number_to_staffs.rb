class AddEmployeeNumberToStaffs < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:staffs, :employee_number)
      add_column :staffs, :employee_number, :string
      add_index :staffs, :employee_number, unique: true
    end
  end
end
