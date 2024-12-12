class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :incident, foreign_key: true
      t.references :staff, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
