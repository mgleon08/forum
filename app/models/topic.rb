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
  has_many :mpictures, dependent: :destroy
  has_many :topic_tag_ships
  has_many :tags, :through => :topic_tag_ships
  accepts_nested_attributes_for :picture, :allow_destroy => true, :reject_if => :all_blank
  accepts_nested_attributes_for :mpictures, :allow_destroy => true, :reject_if => :all_blank

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
