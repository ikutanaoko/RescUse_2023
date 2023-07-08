class Public::ProductsController < ApplicationController
  before_action :authenticate_user!


  def new_index
  end

  def used_index
  end

  def show
    @product = Product.find(params[:id])

  end

  def new
    @product = Product.new
    @tags = Tag.all
  end

  def create
    @product = Product.new(product_params)
    @product.giver_id = current_user.id
    if @product.save!
      flash[:notice] = "新規投稿を行いました"
      redirect_to product_path(@product)
    else

    end

  end

  def edit
  end

  def update
  end

  private

  def product_params
  params.require(:product).permit(:giver_id, :name, :detail_page, :information, :price, :count,
  :is_closed, :is_used, :taker_id, tag_ids: [])
  end


end
