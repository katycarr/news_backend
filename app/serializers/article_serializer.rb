class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :source, :published_at
end
