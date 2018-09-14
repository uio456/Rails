class CreateInvitePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :invite_plans do |t|
      t.references :member, foreign_key: true
      t.references :plan, foreign_key: true
      t.boolean :accept

      t.timestamps
    end
  end
end
