class Admin::DepartmentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @department = Department.new
    @departments = Department.all
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to admin_departments_path notice: "データの追加に成功しました。"
    else
      @departments = Department.all
      remder :index
    end
  end

  def show
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    department = Department.find(params[:id])
    department.update(department_params)
    redirect_to admin_departments_path notice: "データの追加に成功しました。"
  end

#削除機能は未実装
  
  private
  
  def department_params
  params.require(:department).permit(:name)
  end


end
