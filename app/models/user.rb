class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :topic_user_collects
  has_many :likes , :through => :topic_user_collects,:source => :topic
end
