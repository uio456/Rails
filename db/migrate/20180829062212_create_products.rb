class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.boolean :is_available
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
