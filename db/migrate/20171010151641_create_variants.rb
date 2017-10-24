class CreateVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :variants do |t|
      t.references :product, foreign_key: true
      t.string :option_id
      t.timestamps
    end
  end
end
