class BlogSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :body, :published, :created_at, :updated_at

  has_many :comments
end
