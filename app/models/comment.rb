class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :likes
  validates :body, presence: true, length: {minimum: 3} #  presence: true means that validates automatically 

  def author?(user)
    user == self.user
  end
end
