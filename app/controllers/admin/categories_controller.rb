class Admin::CategoriesController < ApplicationController

  def destroy
    @category = Category.find(params[:id])
    if @category.topics.count == 0
      flash[:notice] = "刪除成功"
      @category.destroy
    else
      flash[:alert] = "刪除失敗(類別已有主題)"
    end
    redirect_to admin_topics_path
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "新增成功"
      redirect_to admin_topics_path
    else
      flash[:alert] = "新增失敗(不能留空白)"
      render "new"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "編輯成功"
      redirect_to admin_topics_path
    else
      flash[:alert] = "編輯失敗(不能留空白)"
      render "edit"
    end
  end

  protected

  def category_params
    params.require(:category).permit(:name)
  end
end
