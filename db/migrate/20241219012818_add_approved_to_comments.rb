class AddApprovedToIncidents < ActiveRecord::Migration[6.1]
  def change
    add_column :incidents, :approved, :boolean, default: false
  end
end
