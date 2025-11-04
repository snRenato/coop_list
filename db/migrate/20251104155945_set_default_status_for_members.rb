class SetDefaultStatusForMembers < ActiveRecord::Migration[8.0]
  def change
    change_column_default :members, :status, from: nil, to: "accepted"
  end
end
