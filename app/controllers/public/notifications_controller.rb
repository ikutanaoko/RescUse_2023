class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!
  
def index
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
  
  def destroy
    @notifications = current_user.passive_notifications
    notification = Notification.find(params[:id]).destroy
  end
  
  def destroy_all
    current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
  
end
