class User < ApplicationRecord
  has_secure_password

  has_many :readings
  has_many :user_topics
  has_many :topics, through: :user_topics
end
