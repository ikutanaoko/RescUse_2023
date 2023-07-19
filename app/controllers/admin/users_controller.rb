class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :search
  
  def index
    @users = User.page(params[:page]).per(20)
    
  end
  
  def show
    @user = User.find(params[:id])
    @products = Product.where(giver_id: @user).page(params[:products_page]).per(10)
    @comments = @user.comments.page(params[:comments_page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "情報の更新に成功しました。"
    else
      render "edit"
    end
  end
  
  def search
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page])
  end
  
  def user_params
    params.require(:user).permit( :name, :department_id, :employee_number, :is_deleted)
  end
  
end
