class TopicCommentsController < ApplicationController
  def index
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.new(params.require(:comment).permit(:user_comment))
    @comment.user = current_user
    if @comment.save
      redirect_to topic_path(@topic)
    else
      render topic_path(@topic)
    end
  end
end
