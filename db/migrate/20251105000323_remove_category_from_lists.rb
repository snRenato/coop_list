class RemoveCategoryFromLists < ActiveRecord::Migration[8.0]
  def change
    remove_column :lists, :category, :integer
  end
end
