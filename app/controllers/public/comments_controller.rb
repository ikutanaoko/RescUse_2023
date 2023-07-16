class Public::CommentsController < ApplicationController
    before_action :authenticate_user!

  def index
  end

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comments = @product.comments.order(created_at: :desc)
    @comment_reply = @product.comments.new(comment_params)
    if @comment.save
      if @comment.parent_id.blank?
        @product.create_notification_comment(current_user)
      else
        @product.create_notification_reply(current_user, @comment)
      end
        flash.now[:notice] = "コメントの投稿に成功しました。"
      @comment = Comment.new
      render :index
    else
      flash.now[:alert] = "コメントの投稿に失敗しました。"
      render :index
    end
  end
  

  def show
  end


  def destroy

    @product = Product.find(params[:product_id])
    @comment = Comment.find(params[:id])
    @comments = @product.comments.order(created_at: :desc)
    @comment_reply = @product.comments.new
    if @comment.destroy
      flash.now[:notice] = "コメントを削除しました。"
      render :index
    end
  end

   private
    def comment_params
      params.require(:comment).permit(:body, :user_id, :product_id, :parent_id)
    end

end
