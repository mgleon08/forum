class Admin::TagsController < ApplicationController
  before_action :check_admin

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.topics.count == 0
      flash[:notice] = "刪除成功"
      @tag.destroy
    else
      flash[:alert] = "刪除失敗(標籤已有主題)"
    end
    redirect_to admin_topics_path
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "新增成功"
      redirect_to admin_topics_path
    else
      flash[:alert] = "新增失敗(不能留空白)"
      render "new"
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      flash[:notice] = "編輯成功"
      redirect_to admin_topics_path
    else
      flash[:alert] = "編輯失敗(不能留空白)"
      render "edit"
    end
  end

  protected

  def tag_params
    params.require(:tag).permit(:name)
  end

  def check_admin
    unless current_user.role == "admin"
      raise ActiveRecord::RecordNotFound #導向404
      redirect_to root_path
    end
  end
end
