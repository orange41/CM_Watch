class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description

      t.timestamps
    end

    add_column :incidents, :category_id, :integer
    add_foreign_key :incidents, :categories
  end
end
