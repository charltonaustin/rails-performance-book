class Rental < ApplicationRecord
  belongs_to :customer, counter_cache: true
  belongs_to :inventory
  has_one :store, through: :inventory
  has_one :film, through: :inventory
  has_one :audit, as: :subject
  after_create :generate_create_audit
  
  after_commit :recalculate_store_rentals
  after_create :cache_for_followers
  
  def cache_for_followers
    customer.followers.each do |follower|
      timeline = Rails.cache.read(follower.timeline_cache_key) || []
      Rails.cache.write(follower.timeline_cache_key, timeline.unshift(id)[0..9])
    end
  end
  
  def recalculate_store_rentals
    store.set_most_rented_film!
  end
  
  def self.backfill_audits
    all.each(&:generate_create_audit)
  end
  
  def generate_create_audit
    store.generate_audit('Rental Creation', self, customer) unless audit
  end
end
