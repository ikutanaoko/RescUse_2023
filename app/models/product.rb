class Product < ApplicationRecord
  belongs_to :giver, class_name: 'User', foreign_key: :giver_id
  belongs_to :taker, class_name: 'User', foreign_key: :taker_id, optional: true
  has_many :product_tags, dependent: :destroy
  has_many :tags, through: :product_tags
  has_many :favorites, dependent: :destroy
  has_many :comment
  
  def status
    if is_used == true
      "開封済備品"
    else
      "未開封備品"
    end
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
