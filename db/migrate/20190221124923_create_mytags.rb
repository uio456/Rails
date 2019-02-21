class CreateMytags < ActiveRecord::Migration[5.2]
  def change
    create_table :mytags do |t|
      t.string :name

      t.timestamps
    end
  end
end
