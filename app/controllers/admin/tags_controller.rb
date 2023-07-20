class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(department_params)
    if @tag.save
      flash[:notice] = "データの追加に成功しました"
      redirect_to admin_tags_path
    else
      @tag = Tag.all
      render :index
    end
  end

  def show
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    tag = Tag.find(params[:id])
    tag.update(tag_params)
    flash[:notice] = "データの更新に成功しました"
    redirect_to admin_tags_path
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    flash[:notice] = "データを削除しました"
    redirect_to admin_tags_path
  end

  private

  def department_params
  params.require(:tag).permit(:name)
  end


  
end
