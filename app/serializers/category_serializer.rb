class CategorySerializer
  include JSONAPI::Serializer
  attributes :name
  # has_many :users
end
