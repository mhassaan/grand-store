class CreateOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :options do |t|
			t.string :name
			t.string :display_name
      t.timestamps
    end
  end
end
