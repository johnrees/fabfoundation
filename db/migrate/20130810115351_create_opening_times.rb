class CreateOpeningTimes < ActiveRecord::Migration
  def change
    create_table :opening_times do |t|
      t.references :lab, index: true
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
