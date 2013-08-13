class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.references :lab, index: true
      t.references :creator, index: true
      t.text :state
      t.text :notes

      t.timestamps
    end
  end
end
