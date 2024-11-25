class CreateStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :staffs do |t|
      t.string :employee_number
      t.string :password_digest
      t.string :name

      t.timestamps
    end
  end
end
