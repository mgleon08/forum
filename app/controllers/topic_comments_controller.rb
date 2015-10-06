class TopicCommentsController < ApplicationController

  before_action :authenticate_user!, :except => [:index]
  before_action :find_topic

  def index
  end

  def create
    @comment = @topic.comments.new(comment_params)
    @comment.user = current_user
    @comment.save

    respond_to do |format|
      format.html { redirect_to topic_path(@topic) }
      format.js
    end
  end

  def edit
    @comment = @topic.comments.find(params[:id])
  end

  def update
    @comment = @topic.comments.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "編輯成功"
      redirect_to topic_path(@topic)
    else
      flash.now[:alert] = "編輯失敗(不能留空白)"
      render "edit"
    end
  end

  def destroy
    @comment = @topic.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
     format.html { redirect_to topic_path(@topic)}
     format.js
    end
  end

  private

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end

  def comment_params
    params.require(:comment).permit(:user_comment,:picture_attributes => [:id, :title, :upload, :_destroy])
  end
end
