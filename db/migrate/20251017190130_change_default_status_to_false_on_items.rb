class ChangeDefaultStatusToFalseOnItems < ActiveRecord::Migration[8.0]
  def change
    change_column_default :items, :status, from: nil, to: false
  end
end
