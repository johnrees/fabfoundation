class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :slug
      t.integer :ordinal
      t.string :ancestry

      t.timestamps
    end
  end
end
