class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.references :user

      t.timestamps null: false
    end
  end
end
