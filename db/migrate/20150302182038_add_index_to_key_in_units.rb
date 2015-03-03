class AddIndexToKeyInUnits < ActiveRecord::Migration
  def change
    add_index :units, :key, :unique => true
  end
end
