class CreateLabsUsers < ActiveRecord::Migration
  def change
    create_table :labs_users, id: false do |t|
      t.references :lab
      t.references :user
      t.timestamps
    end
    add_index :labs_users, [:lab_id, :user_id], unique: true
  end
end
