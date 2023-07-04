class Product < ApplicationRecord
  belongs_to :giver, class_name: 'User', foreign_key: :gier_id
  belongs_to :taker, class_name: 'User', foreign_key: :taker_id
end
