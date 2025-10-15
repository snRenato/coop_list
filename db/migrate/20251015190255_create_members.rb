class CreateMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :members do |t|
      t.references :list, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
