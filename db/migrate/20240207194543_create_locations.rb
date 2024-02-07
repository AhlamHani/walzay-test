class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :country

      t.timestamps

      t.index [:name, :country], unique: true
    end
  end
end
