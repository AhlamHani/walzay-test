class CreateActors < ActiveRecord::Migration[7.0]
  def change
    create_table :actors do |t|
      t.string :name

      t.timestamps

      t.index [:name], unique: true
    end
  end
end
