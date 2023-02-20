class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :username
  has_many :facts
  has_many :categories
end
