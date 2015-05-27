class MoviesController < ApplicationController
  def index
    @movies = Movie.all#.page(params[:page])
  end

  def show
  end

  def refresh
    flash[:notice] = "refreshing movies in background"
    Resque.enqueue(YTSCrawler)
    redirect_to movies_path
  end
end
