# frozen_string_literal: true

class MovieController < ApplicationController
  def index
    @movies = Movie.with_average_rate

    if params[:search].present?
      ids = Movie.search(params[:search]).pluck(:id)
      @movies = @movies.where(id: ids)
    end

    if params[:sort]
      sort = params[:sort] == 'average_rate_desc' ? :desc : :asc
      @movies = @movies.order(average_rate: sort) if params[:sort]
    end

    @movies.each(&:enqueue_fetch_poster)
    Movie.wait_for_all_pool_tasks!
  end
end
