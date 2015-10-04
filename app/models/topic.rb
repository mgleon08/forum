class Topic < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :topic_user_collects
  has_many :collects, :through => :topic_user_collects, :source => :user
  has_many :likes
  has_many :subscribes
  has_one :picture, dependent: :destroy
  accepts_nested_attributes_for :picture, :allow_destroy => true, :reject_if => :all_blank
end
