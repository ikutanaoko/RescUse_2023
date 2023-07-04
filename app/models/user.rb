class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  belongs_to :department
  has_many :scores
  has_many :products, foreign_key: :giver_id
  has_many :products, foreign_key: :taker_id
  has_many :favorites, dependent: :destroy
  has_many :comment
  
end
