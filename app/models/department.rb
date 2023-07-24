class Department < ApplicationRecord
  has_many :users
  has_many :scores

  validates :name, presence: true
end
