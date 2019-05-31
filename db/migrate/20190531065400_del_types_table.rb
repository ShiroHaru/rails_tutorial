class DelTypesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :types
  end
end
