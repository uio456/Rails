class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :party
      t.text :politics
      t.integer :age
      t.integer :votes, default: 0

      t.timestamps
    end
  end
end
