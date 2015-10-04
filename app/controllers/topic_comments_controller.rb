class TopicCommentsController < ApplicationController

  before_action :topic_find

  def index
  end

  def create
    @comment = @topic.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save

        format.html {
          redirect_to topic_path(@topic)
          flash[:notice] = "留言成功"
        }
        format.js
      else
        format.html {
          redirect_to topic_path(@topic)
          flash[:alert] = "留言失敗(不能留空白)"
        }
        format.js
      end
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
     format.html {
       redirect_to topic_path(@topic)
     }
    format.js
    end
  end

  private

  def topic_find
    @topic = Topic.find(params[:topic_id])
  end

  def comment_params
    params.require(:comment).permit(:user_comment,:picture_attributes => [:id, :title, :upload, :_destroy])
  end
end
