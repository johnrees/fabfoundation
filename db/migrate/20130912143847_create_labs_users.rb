class CreateLabsUsers < ActiveRecord::Migration
  def change
    create_table :labs_users, id: false do |t|
      t.references :lab
      t.references :user
    end
    add_index :labs_users, [:lab_id, :user_id]
  end
end
