class Product < ApplicationRecord
default_scope -> { order(created_at: :desc) }
  
  belongs_to :giver, class_name: 'User', foreign_key: :giver_id
  belongs_to :taker, class_name: 'User', foreign_key: :taker_id, optional: true
  has_many :product_tags, dependent: :destroy
  has_many :tags, through: :product_tags
  has_many :favorites, dependent: :destroy
  has_many :comments
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  has_many :read_counts, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def status
    if is_used == true
      "開封済"
    else
      "未開封"
    end
  end

  def is_closed?
    if is_closed == true
      "CLOSED"
    else
      "OPEN"
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def create_notification_comment(current_user)
    notification = current_user.active_notifications.new(
      product_id: id,
      visited_id: giver_id,
      action: 'comment'
      )

    #本人からの通知のコメントを作成しない場合以下を記入
    # if notification.visitor_id == notification.visited_id
    #   notification.checked = true
    # end
    if notification.valid?
    notification.save
    end
  end
  
  
  def create_notification_reply(current_user,comment)
    notification = current_user.active_notifications.new(
      parent_id: comment.parent_id,
      visited_id: 
      action: 'reply'
      )

    #本人からの通知のコメントを作成しない場合以下を記入
    # if notification.visitor_id == notification.visited_id
    #   notification.checked = true
    # end
    if notification.valid?
    notification.save
    end
  end


end
