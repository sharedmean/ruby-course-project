class CommentPolicy
    attr_reader :user, :comment
  
    def initialize(user, comment)
      @user = user
      @comment = comment
    end
  
    def destroy? 
      @post = Post.find(comment.post_id)
      comment.author?(user) || @post.author?(user)
    end
  end
  