class Public::CommentsController < ApplicationController
    before_action :authenticate_user!

  def index
  end

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comment.new(comment_params)
    @comment.user_id = current_user.id
    @comments = @product.comment.order(created_at: :desc)
    @comment_reply = @product.comment.new(comment_params)
    if @comment.save!
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

    @product = Product.find(params[:product_id])
    @comment = Comment.find(params[:id])
    @comments = @product.comment.order(created_at: :desc)
    @comment_reply = @product.comment.new
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
