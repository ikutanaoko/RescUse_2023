class Admin::UsersController < ApplicationController
  def show
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
  
  def user_params
    params.require(:user).permit( :name, :department_id, :employee_number, :is_deleted)
  end
  
end
