class ArticleTopic < ApplicationRecord
  belongs_to :article
  belongs_to :topic
end
