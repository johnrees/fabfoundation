class AddLocalityToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :locality, :string
  end
end
