class AddStatusToMembers < ActiveRecord::Migration[8.0]
  def change
    add_column :members, :status, :integer, default: 0, null: false
  end
end
