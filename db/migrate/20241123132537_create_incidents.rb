class CreateIncidents < ActiveRecord::Migration[6.1]
  def change
    create_table :incidents do |t|
      t.string :title
      t.text :description
      t.datetime :occurred_at # 発生日時フィールド
      t.integer :staff_id # スタッフIDフィールド

      t.timestamps
    end

    add_index :incidents, :staff_id # スタッフIDにインデックス
  end
end
