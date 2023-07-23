class Public::TagsController < ApplicationController
  before_action :authenticate_user!

  def show
    if params[:id].present?
      @tag = Tag.find(params[:id])
    else
      @tag = Tag.first
    end
    @products = @tag.products.where(is_closed:"false").page(params[:page])
    @tags = Tag.all
  end

end
