class Comment < ActiveRecord::Base
  validates_presence_of :user_comment

  belongs_to :topic, :counter_cache => "most_comment" # comments_count
  belongs_to :user

  has_one :picture, dependent: :destroy
  accepts_nested_attributes_for :picture, :allow_destroy => true, :reject_if => :all_blank
end
