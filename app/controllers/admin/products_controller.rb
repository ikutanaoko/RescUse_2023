class Admin::ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(20)
  end

  def show
    @product = Product.find(params[:id])
    @comments = @product.comments.page(params[:page]).per(10)

  end


  def update
    product = Product.find(params[:id])
    product.update(is_closed: !product.is_closed)
    redirect_to admin_product_path(product), notice: "情報の更新に成功しました。"
  end

  def destroy
  end

  def search
  end
  
  private

  def product_params
  params.require(:product).permit(:giver_id, :name, :detail_page, :information, :price, :count,
  :is_closed, :is_used, :taker_id, tag_ids: [])
  end


end
