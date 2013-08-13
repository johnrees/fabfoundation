class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :ancestry
      t.text :content
      t.references :commentable, polymorphic: true
      t.timestamps
    end
    add_index :comments, :ancestry
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
