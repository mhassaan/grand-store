class CreateOptionValues < ActiveRecord::Migration[5.1]
  def change
    create_table :option_values do |t|
      t.string :name
      t.string :display_name
      t.references :option, foreign_key: true
      t.timestamps
    end
  end
end
