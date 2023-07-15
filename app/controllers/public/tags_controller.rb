class Public::TagsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    if params[:id].present?
      @tag = Tag.find(params[:id])
    else 
      @tag = Tag.order(:id).first
    end
    @products = @tag.products.page(params[:page])
    @tags = Tag.all  
  end
  
end
