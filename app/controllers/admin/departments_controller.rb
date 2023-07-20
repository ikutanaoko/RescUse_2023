class Admin::DepartmentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @department = Department.new
    @departments = Department.all
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      flash[:notice] = "データの追加に成功しました"
      redirect_to admin_departments_path
    else
      @departments = Department.all
      render :index
    end
  end

  def show
    @department = Department.find(params[:id])
    @users = @department.users.page(params[:page])
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if  @department.update(department_params)
      flash[:notice] = "データの更新に成功しました"
      redirect_to admin_departments_path
    else
      render :edit
    end
  end

  def destroy
    department = Department.find(params[:id])
    department.destroy
    flash[:notice] = "データを削除しました"
    redirect_to admin_tags_path
  end

  private

  def department_params
  params.require(:department).permit(:name)
  end


end
