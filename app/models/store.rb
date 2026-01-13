class Store < ApplicationRecord
  include IdentityCache
  has_many :inventories
  has_many :films, through: :inventories
  belongs_to :most_rented_film, class_name: 'Film'
  
  def generate_audit(event, subject, actor)
    ActiveRecord::Base.connected_to(shard: shard) do
      Audit.create(
        event: event,
        subject: subject,
        actor: actor,
        store: self
      )
    end
  end

    
  def set_most_rented_film!
    update_attribute(
      :most_rented_film_id,
      Rental.joins(:inventory)
            .where(inventory: { store_id: id })
            .group(:film_id).count.max_by { |k, v| v }.last
    )
  end
  
  def shard
    shards = [:shard_one, :shard_two, :shard_three]
    shard_number = self.id % shards.count
    shards[shard_number]
  end
end
