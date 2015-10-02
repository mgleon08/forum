class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :about]
  before_action :set_show, only: [:show]
  before_action :set_post, only: [:edit, :update, :destroy]

  def about
    @topics = Topic.all
    @comments = Comment.all
    @users = User.all
  end

  def bulk_delete
    ids = Array(params[:ids])
    topics = ids.map{ |i| Topic.find_by_id(i) }.compact

    if params[:commit] == "選取刪除"
     topics.each{ |t| t.destroy }
    end
    redirect_to root_path
  end

  def collect
    @topic = Topic.find(params[:id])
    have = true

    current_user.likes.each do |l|
        if l.id == @topic.id
          have = false
          TopicUserCollect.find_by(:topic=>@topic,:user=>current_user).destroy
        end
    end

    if have
      TopicUserCollect.create(:topic=>@topic,:user=>current_user)
      flash[:notice] = "收藏成功"
    else
      flash[:alert] = "取消收藏"
    end
      redirect_to topic_path(:id => @topic)

  end

  def index

    @categories = Category.all
    #判斷是否為登入＆管理員＄一般人
    if current_user && current_user.role == "admin"
      @topics = Topic.all
    elsif current_user
      @topics = Topic.where( ["state = ? OR ( state = ? AND user_id = ?) ", "發布", "草稿", current_user.id ])
    else
      @topics = Topic.where( :state => "發布" )
    end
    #排序
    if params[:category]
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
    #找自己話題
    if params[:user]
      @topics = @topics.where(:user_id => params[:user])
    end

    if params[:keyword]
      @topics = @topics.where( [ "name like ?", "%#{params[:keyword]}%" ] )
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
      flash.now[:alert] = "新增失敗"
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
      flash.now[:alert] = "編輯失敗"
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

  def set_show
    if current_user
      if current_user.role == "admin"
      @topic = Topic.find(params[:id])
      else
      @topic = Topic.where(["state = ? OR ( state = ? AND user_id = ?) ", "發布", "草稿", current_user.id ]).find(params[:id])
      end
    else
      @topic = Topic.where(state: "發布").find(params[:id])
    end
  end

  def set_post
    if current_user.role == "admin"
      @topic = Topic.find(params[:id])
    else
      @topic = current_user.topics.find(params[:id])
    end
  end

  def topic_params
    params.require(:topic).permit(:name,:article,:category_id,:state,:picture_attributes => [:id, :title, :upload, :_destroy] )
  end
end
