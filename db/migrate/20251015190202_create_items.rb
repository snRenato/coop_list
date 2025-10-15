class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :status
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
