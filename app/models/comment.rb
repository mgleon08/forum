class Comment < ActiveRecord::Base
  validates_presence_of :user_comment
  belongs_to :topic
  belongs_to :user
end
