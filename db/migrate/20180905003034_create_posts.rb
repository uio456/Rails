class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :member, foreign_key: true
      t.string :authority, default: "All"
      t.string :view_counts, default: 0
      t.boolean :public, default: true

      t.timestamps
    end
  end
end
