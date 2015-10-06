module TopicsHelper

  def setup_topic(topic)
    topic.build_picture unless topic.picture
    topic
  end

  def is_topic_collect_class(topic)
    if current_user && current_user.is_collect?(topic)
      "btn-warning"
    else
      "btn-default"
    end
  end

  def is_topic_collect_name(topic)
    if current_user && current_user.is_collect?(topic)
      "已收藏"
    else
      "未收藏"
    end
  end

  def topic_collect_user_name(topic)
    topic.collect_users.map{ |u| u.user_name }.join(" ")
  end

end
