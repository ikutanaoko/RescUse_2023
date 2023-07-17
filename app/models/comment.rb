class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  belongs_to :parent, class_name: "Comment", optional: true
  
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  has_many :notifications, foreign_key: :parent_id, dependent: :destroy
  
  validates :body,presence:true
  
  def create_notification_reply(current_user)
    notification = current_user.active_notifications.new(
      parent_id: parent_id,
      visited_id: parent.user_id,
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
