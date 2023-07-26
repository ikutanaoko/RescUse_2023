class Public::UsersController < ApplicationController
    before_action :authenticate_user!

  def show
    @new_products = Product.where(is_used:false, is_closed:false)
    @used_products = Product.where(is_used:true, is_closed:false)
    @notifications = current_user.passive_notifications

    departments = Department.all
    @department_names = []
    @department_active_score = []
    @department_passive_score = []

    departments.each do |department|
      active_score = []
      passive_score = []
      @department_names << department[:name]
      department.scores.each do |score|
        active_score << (score[:active_score] || 0)
        passive_score << (score[:passive_score] || 0)
      end
      @department_active_score << active_score.sum
      @department_passive_score << passive_score.sum
    end
  end

  def edit
  end

  def update
  end

  def products_index
    @products = Product.where(giver_id: current_user.id).order(created_at: :desc).page(params[:page])
  end

end
