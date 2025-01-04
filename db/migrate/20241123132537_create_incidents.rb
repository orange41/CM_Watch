class CreateIncidents < ActiveRecord::Migration[6.1]
  def change
    create_table :incidents do |t|
      t.string :title
      t.text :description
      t.datetime :occurred_at # 発生日時
      t.integer :staff_id # スタッフID

      t.timestamps
    end

    add_index :incidents, :staff_id # スタッフIDインデ
  end
end
