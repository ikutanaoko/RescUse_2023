class Public::CommentsController < ApplicationController
  def index
  end

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comment.new(comment_params)
    @comment.user_id = current_user.id
    
    @comment_reply = @product.comments.new
    if @comment.save
      flash.now[:notice] = "コメントの投稿に成功しました。"
      render :index
    else
      flash.now[:alert] = "コメントの投稿に失敗しました。"
      render :index
    end    
  end  
    
  def show
  end
  
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
      flash.now[:notice] = "コメントを削除しました。"
      render :index
  end
  
   private
    def comment_params
      params.require(:comment).permit(:comment, :user_id, :product_id, :parent_id)
    end
  
end
