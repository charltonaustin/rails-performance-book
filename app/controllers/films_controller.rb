class FilmsController < ApplicationController
  def show
    @film = Film.find(params[:id])
    fresh_when last_modified: @film.updated_at, etag: @film
  end

  def index
    @films = Film.includes(:language, :stores)
  end

  def create
    @film = Film.new params[:film]
    @film.save
    expire_page controller: :home, action: :index
    redirect_to film_path(@film)
  end
end
