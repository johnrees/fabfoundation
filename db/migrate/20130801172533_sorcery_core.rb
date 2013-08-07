class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name

      t.string :email,            :default => nil, :null => false # if you use this field as a username, you might want to make it :null => false.
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil

      t.string :phone
      t.string :public_email
      t.string :public_phone

      t.string :location
      t.string :country_code
      t.float  :latitude
      t.float  :longitude

      t.string :url
      t.string :gender
      t.date :dob

      t.text :bio
      t.string :company

      t.string :avatar

      t.string :language
      t.string :timezone
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end