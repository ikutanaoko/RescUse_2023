class Inquiry < ApplicationRecord
  validates :name, presence:true
  validates :contact, presence:true
  validates :body, presence:true
end
