class CreateHumans < ActiveRecord::Migration
  def change
    create_table :humans do |t|
      t.references :user
      t.references :lab
      t.integer :ordinal
      t.string :full_name
      t.string :details
      t.string :phone
      t.string :email
      t.integer :roles
      t.timestamps
    end

    add_index :humans, [:user_id, :lab_id]
  end
end
