class MovieController < ApplicationController
  def index
    @movies = Movie.with_average_rate

    if params[:search]
      @movies = @movies.joins(:actors).merge(Actor.by_name(params[:search]))
    end

    if params[:sort]
      sort    = params[:sort] == 'average_rate_desc' ? :desc : :asc
      @movies = @movies.order(average_rate: sort)
    end
  end
end