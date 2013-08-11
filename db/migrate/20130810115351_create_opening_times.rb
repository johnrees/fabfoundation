class CreateOpeningTimes < ActiveRecord::Migration
  def change
    create_table :opening_times do |t|
      t.references :lab, index: true
      t.time :start_time
      t.time :end_time
      t.integer :start_day
      t.integer :end_day
      t.timestamps
    end
  end
end
