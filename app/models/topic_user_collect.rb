# better naming: FavoriteTopic
class TopicUserCollect < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
end
