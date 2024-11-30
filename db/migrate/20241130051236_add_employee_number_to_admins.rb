class AddEmployeeNumberToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :employee_number, :string
    add_index :admins, :employee_number, unique: true
  end
end
