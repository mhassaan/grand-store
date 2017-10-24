class CreateCategoryVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :category_variants do |t|
      t.timestamps
    end
  end
end
