class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash.now[:notice] = "コメントを削除しました。"
    redirect_back(fallback_location: root_path)
  end
  
end
