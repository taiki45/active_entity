# Define default type conversion procedures.

ActiveEntity::ConversionDefinitions.set(:Boolean) do |value|
  case value
  when 'true'
    true
  when 'false'
    false
  else
    raise ActiveEntity::CastError.build(:Boolean, value)
  end
end

ActiveEntity::ConversionDefinitions.set(Integer) do |value|
  begin
    Integer(value)
  rescue
    raise ActiveEntity::CastError.build(Integer, value)
  end
end

ActiveEntity::ConversionDefinitions.set(Float) do |value|
  begin
    Float(value)
  rescue
    raise ActiveEntity::CastError.build(Float, value)
  end
end

ActiveEntity::ConversionDefinitions.set(:'ActiveSupport::TimeWithZone') do |value|
  begin
    case value
    when Fixnum, Float
      Time.zone.at(value)
    when String
      Time.zone.parse(value)
    else
      raise ActiveEntity::CastError.build(:'ActiveSupport::TimeWithZone', value)
    end
  rescue ArgumentError
    raise ActiveEntity::CastError.build(:'ActiveSupport::TimeWithZone', value)
  end
end

ActiveEntity::ConversionDefinitions.set(String) do |value|
  if value.respond_to? :to_s
    value.to_s
  else
    raise ActiveEntity::CastError.build(String, value)
  end
end

ActiveEntity::ConversionDefinitions.set(Symbol) do |value|
  if value.respond_to? :to_sym
    value.to_sym
  else
    raise ActiveEntity::CastError.build(Symbol, value)
  end
end
