class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :lab
      t.references :creator
      t.string :name
      t.text :details
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :all_day, default: false, null: false
      t.string :image
      t.timestamps
    end
    add_index :events, :lab_id
    add_index :events, :creator_id
  end
end
