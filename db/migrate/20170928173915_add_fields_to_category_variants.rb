class AddFieldsToCategoryVariants < ActiveRecord::Migration[5.1]
  def change
		add_column :category_variants, :variant_id, :integer
		add_column :category_variants, :category_id, :integer
  end
end
