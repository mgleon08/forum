module TopicsHelper
  def setup_topic(topic)
    topic.build_picture unless topic.picture
    topic
  end
end
