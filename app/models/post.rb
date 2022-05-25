class Post < ApplicationRecord
  has_many :comments
  validates :title, presence: true, length: {minimum: 1} #  presence: true means that validates automatically 
end
