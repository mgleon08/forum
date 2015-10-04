class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :comments, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :topic_user_collects
  has_many :likes
  has_many :likess , :through => :likes, :source => :topic
  has_many :subscribes
  has_many :collects , :through => :topic_user_collects,:source => :topic
  has_one :introduction

  serialize :fb_raw_data

  def get_fb_friendship
    conn = Faraday.new(:url => 'https://graph.facebook.com')

    res = conn.get '/v2.4/me/friends', { :access_token => self.fb_token }

    JSON.parse( res.body )
  end

  def self.get_fb_data(access_token)
    conn = Faraday.new(:url => 'https://graph.facebook.com')
    res = conn.get '/v2.3/me', { :access_token => access_token }

    if res.status == 200
      JSON.parse( res.body )
    else
      Rails.logger.warn(res.body)
      nil
    end
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

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  #def self.from_omniauth(auth)
    #where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     # user.email = auth.info.email
      #user.password = Devise.friendly_token[0,20]
      #user.user_name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
    #end
  #end


  def admin?
    self.role == "admin"
  end

end
