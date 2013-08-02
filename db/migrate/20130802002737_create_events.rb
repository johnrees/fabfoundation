class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :lab
      t.string :name
      t.text :details
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :all_day, default: false, null: false
      t.timestamps
    end
    add_index :events, :lab_id
  end
end
