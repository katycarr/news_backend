class UserTopicSerializer < ActiveModel::Serializer
  belongs_to :topic
  attributes :id
end
