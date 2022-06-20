class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows, {:id => false} do |t|
      t.integer :follower_id
      t.integer :following_id 
      t.timestamps
    end
    execute "ALTER TABLE follows ADD PRIMARY KEY (follower_id, following_id);"
  end
end
