class StoresController < ApplicationController
  def show
    @store = Store.find(params[:id])
    @films = @store.films.includes(:stores, :language)
  end

  def index
    @stores = Store.all
    expires_in 60.seconds
  end
end
