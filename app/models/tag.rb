# TODO: add index to name
class Tag < ActiveRecord::Base
  validates_presence_of :name
  has_many :topic_tag_ships
  has_many :topics, :through => :topic_tag_ships
end
