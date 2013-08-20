class CreateFacilitiesLabs < ActiveRecord::Migration
  def change
    create_table :facilities_labs, id: false do |t|
      t.belongs_to :facility
      t.belongs_to :lab
    end
    add_index :facilities_labs, [:facility_id, :lab_id]
  end
end
