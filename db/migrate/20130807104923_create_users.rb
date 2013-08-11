class CreateUsers < ActiveRecord::Migration
  def change

    create_table :users do |t|

      t.string :first_name
      t.string :last_name

      t.string :state
      t.string :email
      t.string :password_digest

      t.string :phone
      t.string :public_email
      t.string :public_phone

      t.string :city
      t.string :country_code

      t.float  :latitude
      t.float  :longitude

      t.string :url
      t.string :twitter_username
      # t.integer :gender

      t.date :dob

      t.text :bio

      t.string :avatar

      t.string :locale
      t.string :time_zone

      t.string :action_token

      t.boolean :admin, default: false, null: false

      t.timestamps

    end

  end
end
