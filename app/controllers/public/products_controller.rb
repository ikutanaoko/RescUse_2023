class Public::ProductsController < ApplicationController
  before_action :authenticate_user!

  def new_index
    @products = Product.where(is_used:"false")

  end

  def used_index
    @products = Product.where(is_used:"true")


  end

  def show
    @product = Product.find(params[:id])
    @user = @product.giver
    @comments = @product.comment.order(created_at: :desc)
    @comment = Comment.new
    @comment_reply = @product.comment.new

    #1日に1人のユーザーの閲覧を最大1とする場合に使用
    # unless ReadCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user.id, product_id: @product.id)
    current_user.read_counts.create(product_id: @product.id)
    # end
  end

  def new
    @product = Product.new
    @tags = Tag.all


  end

  def reference
    @product = Product.find(params[:id])
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end

  def create
    @product = Product.new(product_params)
    @product.giver_id = current_user.id
    if @product.save!
      flash[:notice] = "新規の投稿が完了しました。"
      if @product.is_used == false
        current_user.scores.create(active_score: 1)
      end
      redirect_to reference_product_path(@product)
    else
      @product_new = Product.new
      render 'new'
    end

  end

  def edit
    @product = Product.find(params[:id])
    @tags = Tag.all
  end

  def update
    image_url, item_url = params[:product][:selected_item].split(" ")
    @product = Product.find(params[:id])
    @product.detail_page = item_url
    if @product.update(product_params)
      redirect_to product_path(@product)
      flash[:notice] = "編集を行いました。"
    else
      render 'edit'
    end
  end

  def confirm
    @product = Product.find(params[:id])
  end

  def take_over
    product = Product.find(params[:id])
    user = current_user
    product.update(taker_id: user.id, is_closed: true)
    flash[:notice] = "担当者に引き取りの通知を行いました。受け渡しのご調整をお願いいたします。"
    current_user.scores.create(passive_score: 1)
    redirect_to users_path
  end

  private

  def product_params
  params.require(:product).permit(:giver_id, :name, :detail_page, :information, :price, :count,
  :is_closed, :is_used, :taker_id, tag_ids: [])
  end


end
