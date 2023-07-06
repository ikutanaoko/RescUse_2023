class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def create
    @tag = Tag.new(department_params)
    if @tag.save
      redirect_to admin_tags_path notice: "データの追加に成功しました。"
    else
      @tag = Tag.all
      remder :index
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
    redirect_to admin_tags_path notice: "データの更新に成功しました。"
  end

#削除機能は未実装

  private

  def department_params
  params.require(:tag).permit(:name)
  end


  
end
