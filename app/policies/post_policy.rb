class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def update? 
    post.author?(user)
  end

  def edit? 
    post.author?(user)
  end

  def destroy? 
    post.author?(user)
  end
end
