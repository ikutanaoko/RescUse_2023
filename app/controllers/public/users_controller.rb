class Public::UsersController < ApplicationController
    before_action :authenticate_user!
  
  def show
    @new_products = Product.where(is_used:"false", is_closed:"false")
    @used_products = Product.where(is_used:"true", is_closed:"false")
    @notifications = current_user.passive_notifications
    @departments = Department.all
    
  end

  def edit
  end
  
  def update
  end
  
  def products_index
    @products = Product.where(giver_id: current_user.id).order(created_at: :desc).page(params[:page])
  end
  
end
