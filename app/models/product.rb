class Product < ApplicationRecord
  belongs_to :giver, class_name: 'User', foreign_key: :gier_id
  belongs_to :taker, class_name: 'User', foreign_key: :taker_id
  has_many :product_tags
  has_many :tags, throught: :product_tags
  has_many :favorites, dependent: :destroy
end
