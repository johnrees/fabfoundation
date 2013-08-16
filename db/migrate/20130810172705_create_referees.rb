class CreateReferees < ActiveRecord::Migration
  def change
    create_table :referees do |t|
      t.references :lab_application, index: true
      t.references :applicant, index: true

      t.timestamps
    end
  end
end
