class Api::V1::CustomerPresenter < Api::V1::Presenter
  attr_reader :resource

  def initialize(customer)
    @resource = customer
  end

  def to_json
    {
      id: resource.id,
      name: resource.name,
      rental_counter: resource.rentals_count
    }
  end
end
