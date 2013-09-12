class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.references :user, index: true
      t.references :lab, index: true
      t.string :state
      t.text :details
      t.timestamps
    end
  end
end
