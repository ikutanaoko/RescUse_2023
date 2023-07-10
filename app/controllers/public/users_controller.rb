class Public::UsersController < ApplicationController
    before_action :authenticate_user!
  
  def show
    @new_products = Product.where(is_used:"false")
    @used_products = Product.where(is_used:"true")
    @user_products = Product.where(giver_id: current_user.id)
    @take_products = Product.where(taker_id: current_user.id)
    
  end

  def edit
  end
  
  def update
  end
  
  def products_index
  end
  
end
