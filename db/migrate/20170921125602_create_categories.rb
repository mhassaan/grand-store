class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.text :title
      t.references :parent,index: true
      t.timestamps
    end
  end
end
