class Comment < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  belongs_to :product
  belongs_to :user
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  has_many :notifications, foreign_key: :parent_id, dependent: :destroy
  
  validates :body, presence:true
  
  def create_notification_reply(current_user,reply_comment_id)
    notification = current_user.active_notifications.new(
      parent_id: parent_id,
      visited_id: Comment.find(reply_comment_id).user.id,
      action: 'reply'
      )
      
    if notification.valid?
    notification.save
    end

    #本人からのコメント通知は削除する
    if notification.visitor_id == notification.visited_id
    notification.destroy
    end
  end
  
end
