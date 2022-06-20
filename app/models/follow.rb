class Follow < ApplicationRecord
  require 'composite_primary_keys'
  set_primary_keys :follower_id, :following_id
  belongs_to :follower, foreign_key: "follower_id", class_name: "User"
  belongs_to :following, foreign_key: "following_id", class_name: "User"  
end
