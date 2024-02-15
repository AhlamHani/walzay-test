module Movie::OmdbConcern
  extend ActiveSupport::Concern

  class_methods do
    def pool
      @@pool
    end

    def wait_availability_in_the_pool!
      sleep(0.1) while pool.length >= pool.max_length
    end

    def wait_for_all_pool_tasks!
      Movie.pool.shutdown
      Movie.pool.wait_for_termination
      @@pool = Concurrent::FixedThreadPool.new(10)
    end
  end

  included do
    @@pool = Concurrent::FixedThreadPool.new(10)

    def omdb_fetching_pool
      self.class.pool
    end

    def enqueue_fetch_poster
      return if omdb.present?

      self.class.wait_availability_in_the_pool!
      Concurrent::Future.execute(executor: self.class.pool) { fetch_movie_poster }
    end

    def fetch_movie_poster
      response = _omdb_make_request(_omdb_build_uri)
      data = _omdb_parse_response(response)
      Rails.logger.debug(data)
      self.omdb = data
      save!
    rescue => e
      Rails.logger.error("Error fetching movie poster: #{e.message}")
    end

    private

    def _omdb_build_uri
      URI::HTTP.build(
        host: 'www.omdbapi.com',
        path: '/',
        query: _omdb_build_query
      )
    end

    def _omdb_build_query
      {
        apikey: Rails.application.credentials.dig(:omdb, :api_key),
        t: CGI.escape(name)
      }.to_query
    end

    def _omdb_make_request(uri)
      response = Net::HTTP.get_response(uri)

      case response
      when Net::HTTPSuccess then
        response.body
      when Net::HTTPRedirection then
        _omdb_make_request(URI(response['location']))
      else
        raise "HTTP Error: #{response.code} #{response.message}"
      end
    end

    def _omdb_parse_response(response)
      JSON.parse(response)
    end
  end
end