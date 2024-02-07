class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.integer :year
      t.string :director

      # t.references :actor, null: false, foreign_key: true
      # t.references :location, null: false, foreign_key: true

      t.timestamps

      t.index [:name], unique: true
    end
  end
end
