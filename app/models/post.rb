class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :title, presence: true, length: {minimum: 2} #  presence: true means that validates automatically 
  validates :picture, presence: true
  #after_commit :post_created_email, on: :create  
  #after_commit :post_updated_email, on: :update 
  mount_uploader :picture, PictureUploader
  
  def author?(user)
    user == self.user
  end

  private

  def post_created_email
    PostMailer.with(post: self).new_post_email.deliver
  end

  def post_updated_email
    PostMailer.with(post: self).edit_post_email.deliver
  end

end
