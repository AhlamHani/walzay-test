namespace :reviews do
  desc 'import from csv'
  task :import, [:file_path] => :environment do |t, args|
    require 'csv'
    file_path  = args[:file_path] || Rails.root.join('lib', 'assets', 'reviews.csv')
    batch_size = args[:batch_size] || 1000

    CSV.open(file_path, headers: true).each_slice(batch_size) do |batch|
      batch.each do |row|
        movie = Movie.find_by(name: row['Movie'])
        user  = User.find_or_create_by(name: row['User'])

        if movie
          Review.find_or_create_by!(
            movie:   movie,
            user:    user,
            rating:  row['Stars'].to_i,
            comment: row['Review']
          )
        else
          puts "Warning: Movie '#{row['Movie']}' does not exist. Skipping review creation."
        end
      end
    end
  end
end