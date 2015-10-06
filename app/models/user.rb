class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :comments, dependent: :destroy
  has_many :topics, dependent: :destroy

  has_many :topic_user_collects
  has_many :collect_topics, :through => :topic_user_collects, :source => :topic


  has_many :likes
  has_many :likess , :through => :likes, :source => :topic # TODO: rename to like_topics

  has_many :subscribes

  has_one :introduction

  serialize :fb_raw_data

  def to_param
    "#{id}-#{user_name}"
  end

  def is_collect?(topic)
     collect_topics.include?(topic)
  end

  def self.from_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_uid( auth.uid )
    if user
      user.user_name = auth.info.name
      user.fb_token = auth.credentials.token
      user.fb_raw_data = auth
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.user_name = auth.info.name
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      existing_user.fb_raw_data = auth
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.user_name = auth.info.name
    user.uid = auth.uid
    user.fb_token = auth.credentials.token
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.fb_raw_data = auth
    user.save!
    return user
  end

  def admin?
    self.role == "admin"
  end

end
