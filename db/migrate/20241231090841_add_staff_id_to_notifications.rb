class AddStaffIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :staff_id, :integer
    add_index :notifications, :staff_id
  end
end
