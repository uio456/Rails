class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :tel
      t.string :intro

      t.timestamps
    end
  end
end
