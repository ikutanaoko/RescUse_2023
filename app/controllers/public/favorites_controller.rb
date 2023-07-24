class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @product = Product.find(params[:product_id])
    favorite = current_user.favorites.new(product_id: @product.id)
    if favorite.save!
      flash.now[:notice] = "お気に入りに追加しました。"
      render 'btn'
    end
  end
  
  def destroy
    @product = Product.find(params[:product_id])
    favorite = current_user.favorites.find_by(product_id: @product.id)
    if favorite.destroy
      flash.now[:notice] = "お気に入りを削除しました。"
      render 'btn'
    end
  end
  
  def index
    favorites = Favorite.where(user_id: current_user.id).pluck(:product_id)
    @favorite_list = Product.find(favorites)
  end
  
end
