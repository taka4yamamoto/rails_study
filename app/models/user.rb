class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }

  has_many :active_relationships, class_name: :Relationship, foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: :Relationship, foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
