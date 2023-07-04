class Tag < ApplicationRecord
  has_many :product_tags
  has_many :products, throught: :product_tags
end
