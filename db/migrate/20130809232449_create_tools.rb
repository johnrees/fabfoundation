class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.references :lab, index: true
      t.references :tool_type, index: true
      t.integer :ordinal
      t.string :name
      t.string :description
      t.string :photo

      t.timestamps
    end
  end
end
