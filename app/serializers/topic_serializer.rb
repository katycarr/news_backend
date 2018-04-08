class TopicSerializer < ActiveModel::Serializer
  attributes :id, :name, :url
  attribute :article_count

  def article_count
    self.object.articles.count
  end
end
