class Public::ProductsController < ApplicationController
  before_action :authenticate_user!

  def new_index
    @products = Product.where(is_used:"false", is_closed:"false").page(params[:page])

  end

  def used_index
    @products = Product.where(is_used:"true", is_closed:"false").page(params[:page])


  end

  def show
    @product = Product.find(params[:id])
    @tags = @product.tags
    @user = @product.giver
    @comments = @product.comments.order(created_at: :desc)
    @comment = Comment.new
    @comment_reply = @product.comments.new

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
    if @product.save
      flash[:notice] = "新規の投稿が完了しました。"
      if @product.is_used == false
        current_user.scores.create(active_score: 1, department_id: current_user.department.id)
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
    @product = Product.find(params[:id])
    if params[:product][:selected_item].present?
      image_url, item_url = params[:product][:selected_item].split(" ")
      @product.detail_page = item_url
      @product.image_url = image_url
    end
    if @product.update(product_params)
      redirect_to product_path(@product)
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
    flash[:notice] = "引き取り完了報告を承りました。"
    current_user.scores.create(passive_score: 1, department_id: user.department.id)
    redirect_to users_path
  end

  private

  def product_params
  params.require(:product).permit(:giver_id, :name, :detail_page, :information, :price, :count,
  :is_closed, :is_used, :taker_id, tag_ids: [])
  end


end
