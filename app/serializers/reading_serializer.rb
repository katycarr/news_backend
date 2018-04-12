class ReadingSerializer < ActiveModel::Serializer
  attributes :id, :read?
  belongs_to :article
end
