class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def about
    @topics = Topic.all
    @comments = Comment.all
    @users = User.all
  end

  def index

    @categories = Category.all

    if params[:order] == "most_comment"
      @topics = Topic.order("most_comment DESC")
    elsif params[:order] == "last_comment"
      @topics = Topic.order("last_comment DESC")
    else
      @topics = Topic.order("id")
    end

    if params[:category]
      @topics = Topic.where(:category_id => params[:category])
    end

      @topics = @topics.page(params[:page]).per(10)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    if @topic.save
      flash[:notice] = "新增成功"
      redirect_to topics_path
    else
      flash[:alert] = "新增失敗"
      render "new"
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      flash[:notice] = "編輯成功"
      redirect_to topics_path
    else
      flash[:alert] = "編輯失敗"
      render "new"
    end

  end

  def show
    @comment = Comment.new
  end

  def destroy
    @topic.destroy
    flash[:notice] = "刪除成功"
    redirect_to topics_path
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name,:article,:category_id)
  end
end