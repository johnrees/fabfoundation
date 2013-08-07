class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :name
      t.string :address
      t.text :address_notes
      t.string :state_code
      t.string :country_code
      t.references :creator
      t.timestamps
    end
    add_index :labs, :name
    add_index :labs, :creator_id
  end
end
