class TopicTagsController < ApplicationController

  before_action :authenticate_user!

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "新增成功"
      redirect_to new_topic_path
    else
      flash[:alert] = "新增失敗(不能留空白)"
      render "new"
    end
  end

  protected

  def tag_params
    params.require(:tag).permit(:name)
  end
end
