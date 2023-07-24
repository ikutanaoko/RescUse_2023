class Public::HomesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def top
  end

  def about
  end

  def index
     @products = Product.where(taker_id: current_user.id).order(created_at: :desc).page(params[:page])
  end
end
