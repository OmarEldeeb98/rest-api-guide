class FactSerializer
  include JSONAPI::Serializer
  attributes :fact, :id
  belongs_to :user
end
