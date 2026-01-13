class Api::V1::Presenter
  def to_json(excludes: [])
    return nil unless resource
    Datadog::Tracing.trace("presenter.to_json",
                           service: 'presentation-layer',
                           resource: resource&.class&.to_s, ) do
      object = Rails.cache.fetch(cache_key)
      if object && object[:expiration_key] == expiration_key
        return object.tap { |h| h.delete(:id) }
      end

      as_json.merge(expiration_key: expiration_key).tap do |object|
        Rails.cache.write(cache_key, object)
        object.delete(:expiration_key)
        excludes.each do |excluded_attribute|
          object.delete(excluded_attribute)
        end
      end
    end
  end

  def expiration_key
    resource.updated_at
  end
end