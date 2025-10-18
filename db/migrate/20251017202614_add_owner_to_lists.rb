class AddOwnerToLists < ActiveRecord::Migration[8.0]
  def change
    add_reference :lists, :owner, null: true, foreign_key: { to_table: :users }
  end
end
