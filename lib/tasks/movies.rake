namespace :movies do
  desc 'import from csv'
  task :import, [:file_path] => :environment do |t, args|
    require 'csv'
    file_path  = args[:file_path] || Rails.root.join('lib', 'assets', 'movies.csv')
    batch_size = args[:batch_size] || 1000

    CSV.open(file_path, headers: true).each_slice(batch_size) do |batch|
      batch.each do |row|
        actor    = Actor.find_or_create_by(name: row['Actor'])
        location = Location.find_or_create_by(name: row['Filming location'], country: row['Country'])

        movie = Movie.find_or_create_by!(
          name:        row['Movie'],
          description: row['Description'],
          year:        row['Year'],
          director:    row['Director']
        )

        movie.actors << actor unless movie.actors.include?(actor)
        movie.locations << location unless movie.locations.include?(location)
      end
    end
  end
end
