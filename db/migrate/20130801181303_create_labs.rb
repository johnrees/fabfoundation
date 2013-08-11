class CreateLabs < ActiveRecord::Migration

  def change

    create_table :labs do |t|

      t.string :ancestry
      t.integer :state
      t.string  :name
      t.text    :description
      t.string  :phone
      t.string  :email
      t.integer :kind

      t.string :street_address_1
      t.string :street_address_2
      t.string :street_address_3
      t.string :city
      t.string :postal_code
      t.string :country_code
      t.string :region
      t.string :subregion
      t.float :latitude
      t.float :longitude

      t.text :opening_hours_bitmask

      t.string :time_zone
      t.text :address_notes

      t.text :opening_hours_notes

      t.text :application_notes
      t.string :avatar
      t.text :urls
      t.references :creator
      t.timestamps

    end

    add_index :labs, :name
    add_index :labs, :state
    add_index :labs, :creator_id
    add_index :labs, :ancestry

  end
end
