class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def about
    @topics = Topic.all
    @comments = Comment.all
    @users = User.all
  end


  def profile

  end

  def index

    @categories = Category.all

    @topics=Topic.all

    if params[:category]
      @topics = @topics.where(:category_id => params[:category])
      if params[:order] == "most_comment"
        @topics = @topics.order("most_comment DESC").where(:category_id => params[:category])
      elsif params[:order] == "last_comment"
        @topics = @topics.order("last_comment DESC").where(:category_id => params[:category])
      elsif params[:order] == "view"
        @topics = @topics.order("view DESC").where(:category_id => params[:category])
      else
        @topics = @topics.order("id DESC").where(:category_id => params[:category])
      end
    else
      if params[:order] == "most_comment"
        @topics = @topics.order("most_comment DESC")
      elsif params[:order] == "last_comment"
        @topics = @topics.order("last_comment DESC")
      elsif params[:order] == "view"
        @topics = @topics.order("view DESC")
      else
        @topics = @topics.order("id DESC")
      end
    end

    if params[:user]
      @topics = @topics.where(:user_id => params[:user])
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
      redirect_to topics_path(:page=>params[:page])
    else
      flash[:alert] = "編輯失敗"
      render "new"
    end

  end

  def show
    @comment = Comment.new
    @topic.view += 1
    @topic.save
  end

  def destroy
    @topic.destroy
    flash[:notice] = "刪除成功"
    redirect_to topics_path(:page=>params[:page])
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name,:article,:category_id,:state)
  end
end
