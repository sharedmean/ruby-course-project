class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes
  mount_uploader :avatar, PictureUploader
  validates :username, presence: true, length: {minimum: 4}
  validates_uniqueness_of :username
  validates_uniqueness_of :email

  has_many :follower_follows, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_follows, source: :follower

  has_many :following_follows, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followings, through: :following_follows, source: :following

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
end
