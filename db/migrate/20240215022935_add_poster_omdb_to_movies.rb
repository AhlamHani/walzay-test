class AddPosterOmdbToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :omdb, :json
  end
end
