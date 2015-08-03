class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :line
      t.integer :order
      t.references :note

      t.timestamps null: false
    end
  end
end
