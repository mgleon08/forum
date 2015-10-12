class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :about]
  before_action :set_post, only: [:show]
  before_action :set_my_post, only: [:edit, :update, :destroy]

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

    if current_user.is_collect?(@topic)
      TopicUserCollect.find_by(:topic => @topic,:user=>current_user).destroy
    else
      TopicUserCollect.create(:topic => @topic, :user=>current_user)
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def like
    @topic = Topic.find(params[:id])

    if current_user.is_like?(@topic)
      Like.find_by(:topic=>@topic,:user=>current_user).destroy
    else
      Like.create(:topic=>@topic,:user=>current_user)
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end

  end

  def subscribe
   @topic = Topic.find(params[:id])

    if current_user.is_subscribe?(@topic)
      Subscribe.find_by(:topic=>@topic,:user=>current_user).destroy
    else
      Subscribe.create(:topic=>@topic,:user=>current_user)
    end

    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end


  def index
    @categories = Category.all
    @tags = Tag.all

    if params[:category]
      @category = Category.find(params[:category])
      @topics = @category.topics
    elsif params[:tag]
      @tag = Tag.find(params[:tag])
      @topics = @tag.topics
    else
      @topics = Topic.all
    end

    if current_user && current_user.admin?
      @topics = @topics.all
    elsif current_user
      @topics = @topics.where(["state = ? OR ( state = ? AND user_id = ?) ", "發布", "草稿", current_user.id ])
    else
      @topics = @topics.where(state: "發布").where("scheduled<(?)",Time.now)
    end

    if ["most_comment", "last_comment", "view", "id"].include?( params[:order] )
      @topics = @topics.order("#{params[:order]} DESC")
    else
      @topics = @topics.order("id DESC")
    end

    #找自己話題
    if params[:user]
      @topics = @topics.where(:user_id => params[:user])
    end

    #關鍵字
    if params[:keyword]
      @topics = @topics.where( [ "name like ?", "%#{params[:keyword]}%" ] )
    end

    @topics = @topics.includes(:user, :category, :tags, :comments => :user ).page(params[:page]).per(10)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user

    if @topic.save
      flash[:notice] = "新增成功"
      if params[:upload]
        params[:upload].each { |image|
          @topic.mmpictures.create(upload: image)
        }
    end
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

    # cookies紀錄
    unless cookies["view-topic-#{@topic.id}"]
      @topic.increment!(:view)
      cookies["view-topic-#{@topic.id}"] = true
    end

    session[:topic_id] = @topic.id

  end

  def destroy
    @topic.destroy
    flash[:notice] = "刪除成功"
    redirect_to topics_path(:page=>params[:page])
  end

  private

  def set_post
    if current_user && current_user.admin?
      @topic = Topic.find(params[:id])
    elsif current_user
      @topic = Topic.where(["state = ? OR ( state = ? AND user_id = ?) ", "發布", "草稿", current_user.id ]).find(params[:id])
    else
      @topic = Topic.where(state: "發布").find(params[:id])
    end
  end

  def set_my_post
    if current_user.admin?
      @topic = Topic.find(params[:id])
    else
      @topic = current_user.topics.find(params[:id])
    end
  end

  def topic_params
    params.require(:topic).permit({galleries: []}, :image,:competence,:id,:name,:article,:category_id,:scheduled,:state,:tag_list,:tag_ids=>[], :mpictures_attributes => [:id, :title, :upload, :_destroy],:picture_attributes => [:id, :title, :upload, :_destroy] )
  end
end
