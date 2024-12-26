class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :notifiable, polymorphic: true, null: false
      t.string :message
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
