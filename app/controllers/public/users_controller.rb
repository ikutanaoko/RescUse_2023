class Public::UsersController < ApplicationController
    before_action :authenticate_user!

  def show
    @new_products = Product.where(is_used:"false", is_closed:"false")
    @used_products = Product.where(is_used:"true", is_closed:"false")
    @notifications = current_user.passive_notifications
    
    # @departmentsとしてそれぞれのスコアを格納するSQL
    # @departments = Department.left_joins(:scores).group(:id).select(:name, "COALESCE(SUM('scores'.'active_score'), 0) AS sum_active_score", "COALESCE(SUM('scores'.'passive_score'), 0) AS sum_passive_score").order(:id)
    
    departments = Department.all
    @department_names = []
    @department_active_score = []
    @department_passive_score = []

    departments.each do |department|
      active_score = []
      passive_score = []
      @department_names << department[:name]
      department.scores.each do |score|
        active_score << score[:active_score]
        passive_score << score[:passive_score]
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
