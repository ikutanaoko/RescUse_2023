class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:employee_number]
         
  belongs_to :department
  has_many :scores
  has_many :products, foreign_key: :giver_id
  has_many :products, foreign_key: :taker_id
  has_many :favorites, dependent: :destroy
  has_many :comment
  has_many :read_counts, dependent: :destroy
  
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  
 # No use email
  def email_required?
    false
  end

  def email_changed?
    false
  end
  
  def will_save_change_to_email?
    false
  end
  
end
