class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :member, foreign_key: true
      t.integer :friend_id
      t.boolean :status, default: false, null: false

      t.timestamps
    end
  end
end
