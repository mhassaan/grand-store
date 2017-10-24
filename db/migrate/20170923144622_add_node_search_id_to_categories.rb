class AddNodeSearchIdToCategories < ActiveRecord::Migration[5.1]
  def change
		add_column :categories, :node_search_id, :integer
		add_index :categories, :node_search_id
  end
end
