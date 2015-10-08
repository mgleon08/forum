class Topic < ActiveRecord::Base

  validates_presence_of :name

  belongs_to :category
  belongs_to :user

  has_many :comments, dependent: :destroy

  has_many :topic_user_collects, dependent: :destroy
  has_many :collect_users, :through => :topic_user_collects, :source => :user

  has_many :likes, dependent: :destroy
  has_many :like_users , :through => :likes, :source => :user # TODO: rename to like_topics

  has_many :subscribes, dependent: :destroy
  has_many :subscribe_users , :through => :subscribes, :source => :user

  has_one :picture, dependent: :destroy
  has_many :mpictures, dependent: :destroy


  has_many :topic_tag_ships
  has_many :tags, :through => :topic_tag_ships

  accepts_nested_attributes_for :picture, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :mpictures, :allow_destroy => true, :reject_if => :all_blank


  def comment_users
    self.comments.map{ |c| c.user }.uniq
  end

  def tag_list
    self.tags.map{ |t| t.name }.join(",")
  end

  def tag_list=(str)
    arr = str.split(",")

    self.tags = arr.map do |t|
      tag = Tag.find_by_name(t)
      unless tag
        tag = Tag.create!( :name => t )
      end
        tag
    end

  end

end


