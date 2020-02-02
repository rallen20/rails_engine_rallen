class DateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :best_day

  attribute :best_day do |object|
    object.best_day
  end
end
