class CreateLabApplications < ActiveRecord::Migration
  def change
    create_table :lab_applications do |t|
      t.references :lab, index: true
      t.references :creator, index: true
      t.string :state, index: true
      t.text :notes

      t.timestamps
    end
  end
end
