class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :ancestry
      t.string :state
      t.string :name
      t.integer :kind
      t.string :address
      t.text :address_notes
      t.string :state_code
      t.string :avatar
      t.float :latitude
      t.float :longitude
      t.string :country_code
      t.text :urls
      t.references :creator
      t.timestamps
    end
    add_index :labs, :name
    add_index :labs, :creator_id
    add_index :labs, :ancestry
  end
end
