module ArForceIndexExtension
  def use_index(index)
    from("#{table_name} USE INDEX (#{index})")
  end

  def force_index(index)
    from("#{table_name} FORCE INDEX (#{index})")
  end
end

ActiveRecord::Relation.include(ArForceIndexExtension)
class ActiveRecord::Base
  def self.use_index(index)
    from("#{table_name} USE INDEX (#{index})")
  end

  def self.force_index(index)
    from("#{table_name} FORCE INDEX (#{index})")
  end
end