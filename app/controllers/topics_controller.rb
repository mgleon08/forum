class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      flash[:notice] = "新增成功"
      redirect_to topics_path
    else
      flash[:alert] = "新增失敗"
      render "new"
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      flash[:notice] = "編輯成功"
      redirect_to topics_path
    else
      flash[:alert] = "編輯失敗"
      render "new"
    end

  end

  def show
    @topic = Topic.find(params[:id])
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    flash[:notice] = "刪除成功"
    redirect_to topics_path
  end



  private
  def topic_params
    params.require(:topic).permit(:name,:article)
  end
end
