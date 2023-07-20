class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:employee_number]
         validates :name, presence: true
         validates :employee_number, presence: true, length: { minimum: 5 }

  belongs_to :department
  has_many :scores
  has_many :products, foreign_key: :giver_id
  has_many :products, foreign_key: :taker_id
  has_many :favorites, dependent: :destroy
  has_many :comments
  has_many :read_counts, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  def active_for_authentication?
    super && (is_deleted == false)
  end


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

  def status
    if is_deleted == false
      "有効"
    else
      "無効"
    end
  end


  def self.ransackable_associations(auth_object = nil)
    ["department"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["employee_number", "name"]
  end


  GUEST_USER_EMPLOYEE_NUMBER = "123456"

  def self.guest
    find_or_create_by!(employee_number: GUEST_USER_EMPLOYEE_NUMBER) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.department = Department.first
      user.name = "guestuser"

    end
  end


  def guest_user?
    employee_number == GUEST_USER_EMPLOYEE_NUMBER
  end


end
