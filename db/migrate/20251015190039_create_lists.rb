class CreateLists < ActiveRecord::Migration[8.0]
  def change
    create_table :lists do |t|
      t.integer :category
      t.string :title

      t.timestamps
    end
  end
end
