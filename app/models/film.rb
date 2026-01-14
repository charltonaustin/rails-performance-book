class Film < ApplicationRecord
  include IdentityCache
  has_many :inventories
  has_many :stores, through: :inventories
  has_many :rentals, through: :inventories

  belongs_to :language

  after_save :write_cache

  def write_cache
    Rails.cache.write(
      "api/v1/films",
      Film.all.map do |film|
        Api::V1::FilmPresenter.new(film).to_json
      end.append(expiration_key: "#{Film.count}-#{updated_at}")
    )
  end
end
