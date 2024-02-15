class MovieController < ApplicationController
  def index
    @movies = Movie.with_average_rate

    @movies = @movies.joins(:actors).merge(Actor.by_name(params[:search])) if params[:search]

    if params[:sort]
      sort = params[:sort] == 'average_rate_desc' ? :desc : :asc
      @movies = @movies.order(average_rate: sort)
    end

    @movies.each(&:enqueue_fetch_poster)
    Movie.wait_the_thread_pool!
  end
end
