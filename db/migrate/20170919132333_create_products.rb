class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.text :name
			t.string :sku
			t.text :description
      t.string :cost_currency
      t.datetime :available_on
      t.decimal :height,precision: 5,scale: 2
      t.decimal :weight,precision: 5,scale: 2
      t.decimal :width,precision: 5,scale: 2
      t.decimal :length,precision: 5,scale: 2
		  t.decimal :master_price,precision: 5,scale: 2
      t.decimal :cost_price,precision: 5,scale: 2
			t.index :sku,:length => {:sku => 50 }
			t.index :name,:length => {:name => 255 }
      t.timestamps
    end
  end
end
