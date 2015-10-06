module TopicsHelper

  def setup_topic(topic)
    topic.build_picture unless topic.picture
    topic
  end


  # 收藏
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


  # Like
  def is_topic_like_class(topic)
    if current_user && current_user.is_like?(topic)
      "btn-info"
    else
      "btn-default"
    end
  end

  def is_topic_like_name(topic)
    if current_user && current_user.is_like?(topic)
      "Like"
    else
      "Unlike"
    end
  end

  def topic_like_user_name(topic)
    topic.like_users.map{ |u| u.user_name }.join(" ")
  end

  # 訂閱
  def is_topic_subscribe_class(topic)
    if current_user && current_user.is_subscribe?(topic)
      "btn-success"
    else
      "btn-default"
    end
  end

  def is_topic_subscribe_name(topic)
    if current_user && current_user.is_subscribe?(topic)
      "subscribe"
    else
      "Unsubscribe"
    end
  end

  def topic_subscribe_user_name(topic)
    topic.subscribe_users.map{ |u| u.user_name }.join(" ")
  end

end
