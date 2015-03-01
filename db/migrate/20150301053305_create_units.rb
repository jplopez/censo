class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :key

      t.timestamps null: false
    end
  end
end
