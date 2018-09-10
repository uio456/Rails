class AddMemberToPlan < ActiveRecord::Migration[5.2]
  def change
    add_reference :plans, :member, foreign_key: true
  end
end
