module TopicCommentsHelper
  def setup_comment(comment)
    comment.build_picture unless comment.picture
    comment
  end
end
