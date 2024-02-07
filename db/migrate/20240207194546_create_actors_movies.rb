class CreateActorsMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :actors_movies, id: false do |t|
      t.belongs_to :movie
      t.belongs_to :actor

      t.timestamps

      t.index [:movie_id, :actor_id], unique: true
    end
  end
end