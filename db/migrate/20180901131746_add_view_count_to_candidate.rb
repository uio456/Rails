class AddViewCountToCandidate < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :view, :integer, default: 0
  end
end
