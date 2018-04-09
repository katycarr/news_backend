class ArticleSerializer < ActiveModel::Serializer
  has_many :topics
  attributes :id, :title, :author, :source, :published_at, :description, :url, :img_url, :reading_time
end
