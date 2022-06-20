class AddUserRefToFollows < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :follows, :users, column: :follower_id
    add_foreign_key :follows, :users, column: :following_id
  end
end
