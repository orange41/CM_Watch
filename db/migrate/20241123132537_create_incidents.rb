class CreateIncidents < ActiveRecord::Migration[6.1]
  def change
    create_table :incidents do |t|
      t.string :title
      t.text :description
      t.datetime :occurred_at # 発生日時フィールドを追加
      t.integer :staff_id # スタッフIDフィールドを追加

      t.timestamps
    end

    add_index :incidents, :staff_id # スタッフIDにインデックスを追加
  end
end
