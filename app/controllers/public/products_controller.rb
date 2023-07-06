class Public::ProductsController < ApplicationController
  before_action :authenticate_user


  def new_index
  end

  def used_index
  end

  def

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product
    
  end
  
  def edit
  end

  def update
  end
  
  private

  def product_params
  params.require(:product).permit(:giver_id, :name, :detail_page, :information, :price, :count, 
  :is_closed, :is_used, :taker_id)
  end


end
