class Inquiry < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  validates :name, presence:true
  validates :contact, presence:true
  validates :body, presence:true
end
