class Public::UsersController < ApplicationController
    before_action :authenticate_user!
  
  def show
    @new_products = Product.where(is_used:"false")
    @used_products = Product.where(is_used:"true")
    
  end

  def edit
  end
  
  def update
  end
  
  def products_index
  end
  
end
