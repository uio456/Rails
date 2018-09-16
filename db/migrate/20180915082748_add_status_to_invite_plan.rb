class AddStatusToInvitePlan < ActiveRecord::Migration[5.2]
  def change
    add_column :invite_plans, :status, :boolean, default: false, null: false
  end
end
