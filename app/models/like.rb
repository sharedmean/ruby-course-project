class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # that's for one like to one post
  # the uniqueness is also made on db level using indexes
  validates :user_id, uniqueness: { scope: :post_id }
end
