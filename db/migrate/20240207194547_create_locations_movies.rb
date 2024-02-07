class CreateLocationsMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :locations_movies, id: false do |t|
      t.belongs_to :movie
      t.belongs_to :location

      t.timestamps

      t.index [:movie_id, :location_id], unique: true
    end
  end
end